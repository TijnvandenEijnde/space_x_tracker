import 'package:flutter/material.dart';

class FlashMessage {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show({
    required BuildContext context,
    required dynamic message,
    Color? color,
    Duration duration = const Duration(seconds: 2),
  }) {
    if (message.runtimeType != String) {
      message = 'Something went wrong';
    }

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Theme.of(context).colorScheme.background),
          textAlign: TextAlign.center,
        ),
        duration: duration,
        backgroundColor: color ?? Theme.of(context).colorScheme.error,
      ),
    );
  }
}
