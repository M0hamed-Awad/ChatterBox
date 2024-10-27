import 'package:chatter_box_app/constants.dart';
import 'package:chatter_box_app/helper/custom_snack_bar_body.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar(
  BuildContext context, {
  required String snackBarMessage,
  required CodeStatus status,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor:
          status == CodeStatus.Failure ? kErrorColor : kSuccessColor,
      content: status == CodeStatus.Failure
          ? CustomSnackBarBody(
              iconColor: const Color(0xFFC14A60),
              icon: Icons.close,
              message: snackBarMessage,
              status: CodeStatus.Failure,
            )
          : CustomSnackBarBody(
              iconColor: const Color(0xff1BD477),
              icon: Icons.check,
              message: snackBarMessage,
              status: CodeStatus.Success,
            ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(0),
    ),
  );
}
