import 'package:flutter/material.dart';

bool snackbarIsShown = false;

Future<void> showAppSnackBar(
  BuildContext context, {
  required String title,
  Duration duration = const Duration(seconds: 4),
}) async {
  snackbarIsShown = true;
  await ScaffoldMessenger.of(context)
      .showSnackBar(
        SnackBar(
          content: Text(title),
          duration: duration,
        ),
      )
      .closed;
  snackbarIsShown = false;
}
