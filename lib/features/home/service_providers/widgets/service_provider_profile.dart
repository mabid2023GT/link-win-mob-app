import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_model.dart';
import 'package:link_win_mob_app/core/utils/enums/days_of_week_enum.dart';
import 'package:link_win_mob_app/providers/service_providers/service_provider_account_notifier.dart';
import 'package:link_win_mob_app/responsive_ui_tools/widgets/layout_builder_child.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';
import 'package:link_win_mob_app/widgets/link_win_text_field_widget.dart';

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

  _displayNameEditIconTapped() {
    _displayNameModeNotifier.value = true;
  }

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
        Size(buttonBoxSize.width * 0.75, buttonBoxSize.height * 0.85);
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
          SizedBox(
            width: buttonBoxSize.width,
            height: buttonBoxSize.height,
            child: _updateCoverPhoto(buttonSize),
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

  _updateCoverPhoto(Size buttonSize) {
    BorderRadius borderRadius = BorderRadius.circular(buttonSize.width * 0.2);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: buttonSize.width,
          height: buttonSize.height,
          decoration: BoxDecoration(
            color: kHeaderColor,
            borderRadius: borderRadius,
            border: Border.all(
              width: 1,
              color: kBlack,
            ),
          ),
          child: Material(
            color: transparent,
            child: InkWell(
              onTap: () {},
              customBorder: RoundedRectangleBorder(
                borderRadius: borderRadius,
              ),
              splashColor: kWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    size: buttonSize.height * 0.6,
                    color: kBlack,
                  ),
                  Text(
                    'Choose Image',
                    style: TextStyle(
                      fontSize: 16,
                      color: kBlack,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
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

  Widget _workTimeRow(Size rowSize, DaysOfWeek day, String? timeRange) {
    Size daySize = Size(rowSize.width * 0.33, rowSize.height);
    Size timeRangeSize = Size(rowSize.width * 0.45, rowSize.height);
    Size editIconSize = Size(rowSize.width * 0.15, rowSize.height);
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
              day.capitalizeFirstLetter(day.name),
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
              timeRange ?? 'Vacation',
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
              onTap: () {},
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
    // Check if the value contains only letters using a regular expression
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Only letters are allowed.';
    }
    // If all validations pass, return null (indicating no error)
    return null;
  }
}
