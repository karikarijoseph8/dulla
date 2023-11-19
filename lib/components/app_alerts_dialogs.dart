import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/screens/dialogs/arrival_dialog.dart';
import 'package:orbit/screens/dialogs/error_dialog.dart';

Future showLoadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SpinKitRing(
        color: Colors.amber,
      ),
    ),
  );
}

void showMessageSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  message,
                  style: TextStyle(
                    color: AppColors.mainYellow,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future showAlertDialog(BuildContext context, String title, String content) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future showErrorDialog(BuildContext context, String title, String content) {
  return showDialog(
      context: context,
      builder: (context) => ErrorDialog(
            title: title,
            body: content,
          ));
}

Future showTripCompletionDialog(BuildContext context) {
  return showDialog(context: context, builder: (context) => ArrivalDialog());
}
