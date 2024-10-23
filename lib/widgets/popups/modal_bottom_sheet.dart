import 'package:flutter/material.dart';
import 'package:link_win_mob_app/core/config/colors.dart';
import 'package:link_win_mob_app/core/models/service_providers/service_providers_work_time_entity.dart';
import 'package:link_win_mob_app/widgets/pickers/start_end_time_picker.dart';
import 'package:link_win_mob_app/widgets/popups/auth/auth_popup.dart';
import 'package:link_win_mob_app/widgets/popups/auth/reset_password_popup.dart';
import 'package:link_win_mob_app/widgets/popups/auth/verification_email_popup.dart';
import 'package:link_win_mob_app/widgets/popups/common/error_popup.dart';
import 'package:link_win_mob_app/widgets/popups/common/waiting_popup.dart';

void _showFixedModalBottomSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    enableDrag: false,
    backgroundColor: transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 1,
      maxChildSize: 1,
      minChildSize: 1,
      builder: (context, scrollController) => child,
    ),
  );
}

void showSignUpPopup(BuildContext context) =>
    _showFixedModalBottomSheet(context, AuthPopup());

void showSignInPopup(BuildContext context) => _showFixedModalBottomSheet(
      context,
      AuthPopup(
        title: 'Signing In ...',
        message: 'Kindly wait a moment; we will be done soon!',
      ),
    );

void showVerificationEmailPopup(BuildContext context) =>
    _showFixedModalBottomSheet(context, VerificationEmailPopup());

void showResetPasswordPopup(BuildContext context) =>
    _showFixedModalBottomSheet(context, ResetPasswordPopup());

void showStartEndTimePickerPopup(
  BuildContext context,
  String dayOfWeek,
  void Function(
    ServiceProvidersWorkTimeEntity newWorkTime,
    VoidCallback onComplete,
  ) onApplyButtonTapped,
) =>
    _showFixedModalBottomSheet(
      context,
      StartEndTimePicker(
        onApplyButtonTapped: onApplyButtonTapped,
        dayOfWeek: dayOfWeek,
      ),
    );

void showWaitingPopup(
  BuildContext context,
  String title,
  String waitingMessage,
  String message,
) =>
    _showFixedModalBottomSheet(
      context,
      WaitingPopup(
        title: title,
        waitingMessage: waitingMessage,
        message: message,
      ),
    );

void showErrorPopup(
  BuildContext context,
  String title,
  String errorMessage,
  String hintMessage,
  String buttonLabel,
  VoidCallback onTap,
) =>
    _showFixedModalBottomSheet(
      context,
      ErrorPopup(
        title: title,
        errorMessage: errorMessage,
        hintMessage: hintMessage,
        buttonLabel: buttonLabel,
        onTap: onTap,
      ),
    );
