import 'package:flutter/material.dart';

class NoticeMenssages {
  static void showErrorMensager(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red[400],
      content: Text(
        message,
      ),
      behavior: SnackBarBehavior.floating,
    ));
  }
   static void showSuccessMensager(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green[400],
      content: Text(
        message,
      ),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
