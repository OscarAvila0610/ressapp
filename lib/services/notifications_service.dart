import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messangerKey =
      GlobalKey<ScaffoldMessengerState>();
  static showSnackbarError(String message) {
    final snackBar = SnackBar(
        backgroundColor: Colors.red.withOpacity(0.9),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ));

    messangerKey.currentState!.showSnackBar(snackBar);
  }

  static showSnackbar(String message) {
    final snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ));

    messangerKey.currentState!.showSnackBar(snackBar);
  }
}
