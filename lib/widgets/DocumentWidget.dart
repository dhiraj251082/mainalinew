import 'package:flutter/material.dart';
import 'package:mainalihr/model/DocumentModel.dart';

class CustomWidgets {
  static Widget buildFilePickerButton(String label, String field, Map<String, String?> selectedFileNames, Function(String) pickFile, List<TextEditingController> documentNameControllers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => pickFile(field),
              child: const Text('Select File'),
            ),
            const SizedBox(width: 10),
            Text(selectedFileNames[field] ?? 'No file selected'),
          ],
        ),
        if (field.startsWith('other')) // If the field is one of the 'other' documents, show the text field
          TextField(
            controller: documentNameControllers[DocumentModel.documentFieldsList.indexOf(field)],
            decoration: const InputDecoration(
              labelText: 'Enter document name',
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}
