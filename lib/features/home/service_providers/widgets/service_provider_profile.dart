import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_model.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_work_time_entity.dart';
import 'package:link_win_mob_app/core/utils/enums/days_of_week_enum.dart';
import 'package:link_win_mob_app/providers/service_providers/service_provider_account_notifier.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/buttons/link_win_button.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';
import 'package:link_win_mob_app/widgets/link_win_text_field_widget.dart';
import 'package:link_win_mob_app/widgets/popups/modal_bottom_sheet.dart';

class ServiceProviderProfile extends ConsumerStatefulWidget {
  const ServiceProviderProfile({super.key});

  @override
  ConsumerState<ServiceProviderProfile> createState() =>
      _ServiceProviderProfileState();
}

class _ServiceProviderProfileState
    extends ConsumerState<ServiceProviderProfile> {
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _displayNameModeNotifier = ValueNotifier(false);
  String _displayNameTemp = '';

  @override
  Widget build(BuildContext context) {
    final ServiceProvidersModel myAccount =
        ref.watch(serviceProviderAccountProvider);

    return LayoutChildBuilder(
      child: (minSize, maxSize) {
        Size displayNameBoxSize =
            Size(maxSize.width * 0.9, maxSize.height * 0.15);
        Size coverPhotoBoxSize =
            Size(maxSize.width * 0.9, maxSize.height * 0.4);
        Size updateAvailabilityBoxSize =
            Size(coverPhotoBoxSize.width, maxSize.height * 0.15);
        Size workTimeBoxSize =
            Size(coverPhotoBoxSize.width, maxSize.height * 0.9);
        Size saveButtonSize =
            Size(coverPhotoBoxSize.width * 0.5, maxSize.height * 0.125);
        double space = maxSize.height * 0.025;
        return SingleChildScrollView(
          child: Column(
            children: [
              _space(space),
              _displayName(displayNameBoxSize, myAccount),
              _space(space),
              _coverPhotoBox(coverPhotoBoxSize, myAccount),
              _space(space),
              _updateAvailabilityBox(updateAvailabilityBoxSize, myAccount),
              _space(space),
              _workTimeBox(workTimeBoxSize, myAccount),
              _space(space),
              SizedBox(
                width: saveButtonSize.width,
                height: saveButtonSize.height,
                child: LWButton(label: 'Save', onTap: _onSaveButtonTapped),
              ),
              _space(maxSize.height * 0.2),
            ],
          ),
        );
      },
    );
  }

  _displayName(
    Size size,
    ServiceProvidersModel myAccount,
  ) {
    Size labelSize = Size(size.width * 0.8, size.height);
    Size iconSize = Size(size.width * 0.2, size.height * 0.7);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: labelSize.width,
          height: labelSize.height,
          alignment: AlignmentDirectional.center,
          child: _displayNameBoxTextWidget(myAccount),
        ),
        _displayNameBoxIcon(iconSize)
      ],
    );
  }

  _displayNameBoxTextWidget(ServiceProvidersModel myAccount) {
    return ValueListenableBuilder(
      valueListenable: _displayNameModeNotifier,
      builder: (context, isEditMode, child) {
        return isEditMode
            ? Form(
                key: _formKey,
                child: LWTextFieldWidget(
                  label: myAccount.displayName,
                  hint: 'Enter display name',
                  icon: FontAwesomeIcons.user,
                  errorFontSize: 12,
                  onChanged: _onDisplayNameValueChanged,
                  validateValue: _validateDisplayNameValue,
                ),
              )
            : Text(
                'Name: ${myAccount.displayName}',
                style: TextStyle(
                  fontSize: 16,
                  color: kBlack,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lato',
                ),
              );
      },
    );
  }

  _displayNameBoxIcon(Size iconSize) {
    return Card(
      elevation: 5,
      shape: CircleBorder(),
      child: Container(
        width: iconSize.width,
        height: iconSize.height,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: kWhite,
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: kBlack,
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: _displayNameModeNotifier,
          builder: (context, isEditMode, child) {
            return LinkWinIcon(
              iconSize: iconSize,
              splashColor: kHeaderColor,
              iconColor: kBlack,
              iconData: isEditMode ? Icons.save : Icons.edit,
              iconSizeRatio: 0.6,
              onTap: () => isEditMode
                  ? _displayNameSaveIconTapped()
                  : _displayNameEditIconTapped(),
            );
          },
        ),
      ),
    );
  }

  _displayNameEditIconTapped() => _displayNameModeNotifier.value = true;

  _displayNameSaveIconTapped() async {
    // close / hide the keyboard
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
    if (_formKey.currentState!.validate() && _displayNameTemp.isNotEmpty) {
      // update the provider
      await ref
          .read(serviceProviderAccountProvider.notifier)
          .updateDisplayName(_displayNameTemp);
      // update the edit mode
      _displayNameModeNotifier.value = false;
    }
  }

  _coverPhotoBox(
    Size size,
    ServiceProvidersModel myAccount,
  ) {
    Size photoSize = Size(size.width, size.height * 0.7);
    Size buttonBoxSize = Size(size.width, size.height - photoSize.height);
    Size buttonSize =
        Size(buttonBoxSize.width * 0.75, buttonBoxSize.height * 0.75);
    double sidePad = (buttonBoxSize.width - buttonSize.width) * 0.5;
    double topBottomPad = (buttonBoxSize.height - buttonSize.height) * 0.5;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          SizedBox(
            width: photoSize.width,
            height: photoSize.height,
            child: _coverPhoto(photoSize, myAccount),
          ),
          Container(
            width: buttonBoxSize.width,
            height: buttonBoxSize.height,
            padding: EdgeInsets.only(
              left: sidePad,
              right: sidePad,
              top: topBottomPad,
              bottom: topBottomPad,
            ),
            child: LWButton(
              label: 'Choose Image',
              onTap: () {},
              iconData: Icons.photo_library_outlined,
            ),
          ),
        ],
      ),
    );
  }

  _coverPhoto(Size photoSize, ServiceProvidersModel myAccount) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(photoSize.width * 0.1),
      child: Image.network(
        myAccount.coverPhotoPath,
        fit: BoxFit.cover,
        height: photoSize.height,
        width: double.infinity,
        // Use the errorBuilder to handle cases where the image cannot be loaded
        errorBuilder: (context, error, stackTrace) => Container(
          color: kWhite,
          child: Icon(
            Icons.image_not_supported,
            size: photoSize.height * 0.4,
            color: kHeaderColor,
          ),
        ),
      ),
    );
  }

  _updateAvailabilityBox(
    Size size,
    ServiceProvidersModel myAccount,
  ) {
    double checkBoxSize = size.height * 0.4;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            FontAwesomeIcons.clock,
            size: checkBoxSize,
            color: myAccount.isCurrentlyAvailable ? Colors.green : kRed,
          ),
          Text(
            "I'm currently available!",
            style: TextStyle(
              fontSize: 16,
              color: kBlack,
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
            ),
          ),
          InkWell(
            onTap: () async {
              await ref
                  .read(serviceProviderAccountProvider.notifier)
                  .updateAvailability(!myAccount.isCurrentlyAvailable);
            },
            child: Container(
              width: checkBoxSize,
              height: checkBoxSize,
              decoration: BoxDecoration(
                color: kWhite,
                border: Border.all(
                  width: 1,
                  color: kBlack,
                ),
                shape: BoxShape.rectangle,
              ),
              alignment: AlignmentDirectional.center,
              child: Visibility(
                visible: myAccount.isCurrentlyAvailable,
                child: Icon(
                  FontAwesomeIcons.check,
                  size: checkBoxSize * 0.6,
                  color: Colors.green,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _workTimeBox(
    Size size,
    ServiceProvidersModel myAccount,
  ) {
    Size rowSize = Size(size.width * 0.95, size.height * 0.13);
    double sidePad = (size.width - rowSize.width) * 0.5;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Card(
        elevation: 10,
        color: kWhite,
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: sidePad,
            end: sidePad,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: DaysOfWeekExtension.toList()
                .map(
                  (day) =>
                      _workTimeRow(rowSize, day, myAccount.workTime[day.name]),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _workTimeRow(Size rowSize, DaysOfWeek day,
      ServiceProvidersWorkTimeEntity? workTimeEntity) {
    Size daySize = Size(rowSize.width * 0.33, rowSize.height);
    Size timeRangeSize = Size(rowSize.width * 0.45, rowSize.height);
    Size editIconSize = Size(rowSize.width * 0.15, rowSize.height);
    String dayOfWeek = day.capitalizeFirstLetter(day.name);
    String timeRange = workTimeEntity?.displayTime() ?? 'Vacation';
    return SizedBox(
      width: rowSize.width,
      height: rowSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: daySize.width,
            height: daySize.height,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              dayOfWeek,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
              ),
            ),
          ),
          Container(
            width: timeRangeSize.width,
            height: timeRangeSize.height,
            alignment: AlignmentDirectional.center,
            child: Text(
              timeRange,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Lato',
              ),
            ),
          ),
          Container(
            width: editIconSize.width,
            height: editIconSize.height,
            alignment: AlignmentDirectional.center,
            child: LinkWinIcon(
              iconSize: editIconSize,
              splashColor: kHeaderColor,
              iconColor: kBlack,
              iconData: FontAwesomeIcons.penToSquare,
              iconSizeRatio: 0.5,
              onTap: () => showStartEndTimePickerPopup(
                context,
                day.name,
                (newWorkTime, onComplete) async {
                  // update worktime using provider
                  await ref
                      .read(serviceProviderAccountProvider.notifier)
                      .updateWorkTimeEntity(newWorkTime);
                  onComplete();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _space(double space) => SizedBox(
        height: space,
      );

  void _onDisplayNameValueChanged(String value) {
    _displayNameTemp = value;
  }

  String? _validateDisplayNameValue(String? value) {
    // Check if the value is null or empty
    if (value == null || value.isEmpty) {
      return 'Name cannot be blank.';
    }
    // Check if the length is greater than or equal to 20 characters
    if (value.length >= 20) {
      return 'Must be under 20 characters.';
    }
    // Check if the value contains only letters, numbers, and spaces using a regular expression
    if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)) {
      return 'Only letters and numbers are allowed.';
    }
    // If all validations pass, return null (indicating no error)
    return null;
  }

  void _onSaveButtonTapped() async {
    showWaitingPopup(context, 'Saving Changes', 'Saving in progress...',
        'Your patience is appreciated!');
    await ref.read(serviceProviderAccountProvider.notifier).saveUpdatedInfo(() {
      // hide waiting popup
      Navigator.of(context).pop();
    }, (error) {
      // hide waiting popup
      Navigator.of(context).pop();
      showErrorPopup(
        context,
        'Error Occurred',
        error,
        'Try Later!',
        'Close',
        () {
          // hide error popup
          Navigator.of(context).pop();
        },
      );
    });
  }
}
