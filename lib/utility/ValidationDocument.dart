import 'package:flutter/material.dart';
import 'package:mainalihr/model/DocumentModel.dart';

class ValidationUtil {
  static bool validateFields(DocumentModel document, List<TextEditingController> documentNameControllers, BuildContext context) {
    if (document.applicationId.isEmpty ||
        document.passportFront == null ||
        document.passportBack == null ||
        document.passportFull == null ||
        document.highestQualification == null ||
        document.fullLengthPhoto == null ||
        document.vCertificate == null ||
        document.passportSizePhoto == null ||
        (document.other1 != null && documentNameControllers[9].text.isEmpty) ||
        (document.other2 != null && document.otherName2.isEmpty) ||
        (document.other3 != null && document.otherName3.isEmpty) ||
        (document.other4 != null && document.otherName4.isEmpty)) {
      
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Please select files for all required fields.'),
                if (document.applicationId.isEmpty)
                  const Text(
                    'Application ID not found. Contact Mainali HR or register your personal details.',
                    style: TextStyle(color: Colors.red),
                  ),
                if (document.passportFront == null) const Text('Passport Front Required', style: TextStyle(color: Colors.red)),
                if (document.passportBack == null) const Text('Passport Back Required', style: TextStyle(color: Colors.red)),
                if (document.passportFull == null) const Text('Passport Full Required', style: TextStyle(color: Colors.red)),
                if (document.highestQualification == null) const Text('Highest Qualification Required', style: TextStyle(color: Colors.red)),
                if (document.fullLengthPhoto == null) const Text('Full Length Photo Required', style: TextStyle(color: Colors.red)),
                if (document.passportSizePhoto == null) const Text('Passport Size Photo Required', style: TextStyle(color: Colors.red)),
                if (document.other1 != null && documentNameControllers[9].text.isEmpty) const Text('Other Name1 Required', style: TextStyle(color: Colors.red)),
                if (document.other2 != null && document.otherName2.isEmpty) const Text('Other Name2 Required', style: TextStyle(color: Colors.red)),
                if (document.other3 != null && document.otherName3.isEmpty) const Text('Other Name3 Required', style: TextStyle(color: Colors.red)),
                if (document.other4 != null && document.otherName4.isEmpty) const Text('Other Name4 Required', style: TextStyle(color: Colors.red)),
              ],
            ),
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
      return false;
    }
    return true;
  }
}
