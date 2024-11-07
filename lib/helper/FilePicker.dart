import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mainalihr/utility/image_utils.dart'; // Import the image compression utility
import 'package:mainalihr/widgets/ProgressDialog.dart';

class FilePickerUtil {
  static Future<File?> pickFile(BuildContext context, String field, Map<String, String?> selectedFileNames) async {
    // Show the ProgressDialog
    showDialog(
      barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
      context: context,
      builder: (BuildContext context) => const ProgressDialog(status: 'Please wait...'),
    );

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    // Dismiss the ProgressDialog
    Navigator.of(context).pop();

    try {
      if (result != null && result.files.isNotEmpty) {
        File selectedFile = File(result.files.single.path!);
        String fileName = selectedFile.uri.pathSegments.last; // Extract file name
        String fileExtension = fileName.split('.').last; // Extract file extension
        int fileSize = await selectedFile.length();

        // Check if the file extension is valid
        if (!['pdf', 'jpg', 'jpeg', 'png'].contains(fileExtension.toLowerCase())) {
          _showErrorDialog(context, 'Invalid File Type',
              'Invalid file "$fileName". Use: pdf, jpg, jpeg, png.');
          return null;
        }

        // Handle file size and compression for images
        if (['jpg', 'jpeg', 'png'].contains(fileExtension.toLowerCase())) {
          if (fileSize > 3145728) { // Larger than 3 MB
            _showErrorDialog(context, 'File Size Error',
                'The selected image file "$fileName" is larger than 3 MB. Compression is not possible.');
            return null;
          } else if (fileSize > 1048576) { // Larger than 1 MB but less than or equal to 3 MB
            File? compressedFile = await ImageCompressionUtil.compressImage(selectedFile);
            if (compressedFile != null) {
              int compressedFileSize = await compressedFile.length();
              if (compressedFileSize <= 1048576) { // Less than or equal to 1 MB
                selectedFileNames[field] = compressedFile.uri.pathSegments.last;
                return compressedFile;
              } else {
                _showErrorDialog(context, 'Compression Failed',
                    'Compression failed. The image file "$fileName" could not be reduced to below 1 MB. Please select a smaller file.');
                return null;
              }
            }
          }
        }

        // Handle PDFs
        if (fileExtension.toLowerCase() == 'pdf') {
          if (fileSize > 1048576) { // Larger than 1 MB
            _showErrorDialog(context, 'File Size Warning',
                'The selected PDF file "$fileName" is larger than 1 MB. PDF compression is not available.');
          }
        }

        selectedFileNames[field] = fileName;
        return selectedFile;
      } else {
        print('File picking canceled.');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
    return null;
  }

  static void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
