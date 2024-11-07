import 'package:flutter/material.dart';

Future<String?> showFileNameDialog(BuildContext context) async {
  TextEditingController fileNameController = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Please provide a file name'),
        content: TextField(
          controller: fileNameController,
          decoration: const InputDecoration(hintText: 'File name'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(fileNameController.text);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
