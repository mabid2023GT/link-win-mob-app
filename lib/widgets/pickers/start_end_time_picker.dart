import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_work_time_entity.dart';
import 'package:link_win_mob_app/core/utils/screen_util.dart';
import 'package:link_win_mob_app/widgets/buttons/link_win_button.dart';
import 'package:link_win_mob_app/widgets/link_win_icon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartEndTimePicker extends ConsumerStatefulWidget {
  final String dayOfWeek;
  final void Function(
    ServiceProvidersWorkTimeEntity newWorkTime,
    VoidCallback onComplete,
  ) onApplyButtonTapped;

  const StartEndTimePicker({
    super.key,
    required this.dayOfWeek,
    required this.onApplyButtonTapped,
  });

  @override
  ConsumerState<StartEndTimePicker> createState() => _StartEndTimePickerState();
}

class _StartEndTimePickerState extends ConsumerState<StartEndTimePicker> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  late Map<String, dynamic> newWorkTime;
  bool _isAvailableChecked = false;
  String _errorMessageText = '';

  @override
  void initState() {
    super.initState();
    newWorkTime = {
      ServiceProvidersWorkTimeEntityConstants.day.name: widget.dayOfWeek,
      ServiceProvidersWorkTimeEntityConstants.startTime.name: '',
      ServiceProvidersWorkTimeEntityConstants.endTime.name: '',
      ServiceProvidersWorkTimeEntityConstants.isVacation.name: false,
    };
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _endTime) {
      if (_startTime == null ||
          !_isEndTimeAfterStartTime(_startTime!, picked)) {
        setState(() {
          _errorMessageText = '* End time must be after start time.';
        });
      } else {
        setState(() {
          _endTime = picked;
          _errorMessageText = '';
        });
      }
    }
  }

  // Helper method to check if the end time is after the start time
  bool _isEndTimeAfterStartTime(TimeOfDay startTime, TimeOfDay endTime) {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;
    return endMinutes > startMinutes;
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return '';
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = ScreenUtil(context).size;
    Size popupSize = Size(screenSize.width * 0.75, screenSize.height * 0.6);
    double sidePad = (screenSize.width - popupSize.width) * 0.5;
    double topBottomPad = (screenSize.height - popupSize.height) * 0.5;
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      color: transparent,
      padding: EdgeInsets.only(
        left: sidePad,
        right: sidePad,
        top: topBottomPad,
        bottom: topBottomPad,
      ),
      child: Container(
        width: popupSize.width,
        height: popupSize.height,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(popupSize.width * 0.2),
          border: Border.all(
            width: 1,
            color: kBlack,
          ),
        ),
        child: _body(popupSize),
      ),
    );
  }

  _body(Size size) {
    double sidePad = size.width * 0.075;
    double topBottomPad = size.height * 0.05;
    Size bodySize =
        Size(size.width - 2 * sidePad, size.height - 2 * topBottomPad);
    double closeButtonSize = bodySize.width * 0.15;

    Size childSize = Size(bodySize.width * 0.9, bodySize.height * 0.15);
    double topSpaceBetweenChildren = bodySize.height * 0.05;
    double headerSpace = bodySize.height * 0.05;
    return Padding(
      padding: EdgeInsets.only(
        left: sidePad,
        right: sidePad,
        top: topBottomPad,
        bottom: topBottomPad,
      ),
      child: SizedBox(
        width: bodySize.width,
        height: bodySize.height,
        child: Stack(
          children: [
            _closeIcon(closeButtonSize),
            _isVacationBox(
              childSize,
              topSpaceBetweenChildren + headerSpace,
            ),
            _visibilityTimeBox(childSize,
                childSize.height + 2 * topSpaceBetweenChildren, true),
            _visibilityTimeBox(childSize,
                2 * childSize.height + 3 * topSpaceBetweenChildren, false),
            Visibility(
              visible: !_isAvailableChecked,
              child: _errorMessage(childSize,
                  3 * childSize.height + 4 * topSpaceBetweenChildren),
            ),
            _save(
                childSize, 4 * childSize.height + 5 * topSpaceBetweenChildren),
          ],
        ),
      ),
    );
  }

  _errorMessage(Size size, double topPos) {
    return Positioned(
      top: topPos,
      left: 0,
      right: 0,
      child: Container(
        width: size.width,
        height: size.height,
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          _errorMessageText,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Lato',
            color: kRed,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _visibilityTimeBox(Size childSize, double topPos, bool isStarTime) {
    return Visibility(
      visible: !_isAvailableChecked,
      child: _timeBox(
        topPos: topPos,
        size: childSize,
        title: isStarTime ? 'Start Time' : 'End Time',
        selectedTime: _formatTime(isStarTime ? _startTime : _endTime),
        onTap: () =>
            isStarTime ? _selectStartTime(context) : _selectEndTime(context),
      ),
    );
  }

  _closeIcon(double iconSize) {
    return Positioned(
      top: 0,
      right: 0,
      child: LinkWinIcon(
        iconSize: Size(iconSize, iconSize),
        splashColor: kHeaderColor,
        iconColor: kBlack,
        iconData: FontAwesomeIcons.xmark,
        iconSizeRatio: 0.8,
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }

  _isVacationBox(Size size, double space) {
    double checkBoxSize = size.height * 0.4;
    return Positioned(
      top: space,
      left: 0,
      right: 0,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Vacation',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Lato',
              ),
            ),
            _isAvailableCheckBox(
              checkBoxSize,
            ),
          ],
        ),
      ),
    );
  }

  _timeBox({
    required Size size,
    required double topPos,
    required String title,
    required String selectedTime,
    required VoidCallback onTap,
  }) {
    double iconSize = size.height * 0.6;
    return Positioned(
      top: topPos,
      left: 0,
      right: 0,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _timeContent(size, title, selectedTime),
            _timePickerIcon(iconSize, onTap),
          ],
        ),
      ),
    );
  }

  _timeContent(Size size, String title, String selectedTime) {
    return SizedBox(
      width: size.width * 0.7,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Lato',
            ),
          ),
          Text(
            selectedTime,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Lato',
            ),
          ),
        ],
      ),
    );
  }

  _timePickerIcon(double iconSize, VoidCallback onTap) {
    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: kHeaderColor,
        shape: BoxShape.circle,
      ),
      child: LinkWinIcon(
        iconSize: Size(iconSize, iconSize),
        splashColor: kWhite,
        iconColor: kBlack,
        iconData: Icons.access_time,
        iconSizeRatio: 0.6,
        onTap: onTap,
      ),
    );
  }

  _save(Size size, double topPos) {
    Size childSize = Size(size.width * 0.5, size.height * 0.75);
    double sidePos = (size.width - childSize.width) * 0.5;
    bool isErrorOccurred = _errorMessageText.isNotEmpty;
    return Positioned(
      top: topPos,
      left: sidePos,
      right: sidePos,
      child: SizedBox(
        width: childSize.width,
        height: childSize.height,
        child: LWButton(
          label: 'Apply',
          bgColor: isErrorOccurred ? k1Gray.withOpacity(0.5) : kHeaderColor,
          splashColor: isErrorOccurred ? null : kWhite,
          onTap: isErrorOccurred
              ? () {}
              : () {
                  newWorkTime[ServiceProvidersWorkTimeEntityConstants
                          .startTime.name] =
                      _isAvailableChecked ? '' : _formatTime(_startTime);
                  newWorkTime[ServiceProvidersWorkTimeEntityConstants.endTime
                      .name] = _isAvailableChecked ? '' : _formatTime(_endTime);
                  newWorkTime[ServiceProvidersWorkTimeEntityConstants
                      .isVacation.name] = _isAvailableChecked;
                  widget.onApplyButtonTapped(
                      ServiceProvidersWorkTimeEntity.fromMap(newWorkTime), () {
                    // close the time picker popup
                    Navigator.of(context).pop();
                  });
                },
        ),
      ),
    );
  }

  _isAvailableCheckBox(double checkBoxSize) {
    return InkWell(
      onTap: () {
        setState(() {
          _isAvailableChecked = !_isAvailableChecked;
        });
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
          visible: _isAvailableChecked,
          child: Icon(
            FontAwesomeIcons.check,
            size: checkBoxSize * 0.6,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
