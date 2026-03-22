import 'package:flutter/material.dart';

class PopupWidget {
  static Future<void> showAlert(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Hint'),
        content: const Text('Long press and drag to reorder stocks'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
}