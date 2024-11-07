import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/dialog/showFileNameDialog.dart';
import 'package:mainalihr/helper/FilePicker.dart';
import 'package:mainalihr/utility/uploadDocumentToServer.dart';
import 'package:mainalihr/widgets/ProgressDialog.dart';
import 'package:provider/provider.dart';


class UploadDocumentView extends StatefulWidget {
  const UploadDocumentView({super.key});

  @override
  _UploadDocumentViewState createState() => _UploadDocumentViewState();
}

class _UploadDocumentViewState extends State<UploadDocumentView> {
  Map<String, File?> selectedFiles = {};
  Map<String, String?> selectedFileNames = {};
  Map<String, String?> customFileNames = {};
  List<TextEditingController> documentNameControllers = List.generate(13, (index) => TextEditingController());

  String? applicantid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final applicationId = ModalRoute.of(context)!.settings.arguments as String?;
    print("The application ID: $applicationId");

    final userProvider = Provider.of<UserProvider>(context);
    final userCredentials = userProvider.userCredentials;
    final userid = userCredentials?.userId ?? "Guest";
    final username = userCredentials?.username ?? "Guest";

    if (username != "Guest") {
      applicantid = userid;
    } else {
      applicantid = applicationId.toString();
    }

    setState(() {});
  }

  void pickFile(String field) async {
    File? file = await FilePickerUtil.pickFile(context, field, selectedFileNames);
    if (file != null) {
      if (field.startsWith('other')) {
        String? fileName = await showFileNameDialog(context);
        if (fileName != null && fileName.isNotEmpty) {
          setState(() {
            selectedFiles[field] = file;
            selectedFileNames[field] = file.path.split('/').last;
            customFileNames[field] = fileName;
          });
        }
      } else {
        setState(() {
          selectedFiles[field] = file;
          selectedFileNames[field] = file.path.split('/').last;
        });
      }
    }
  }
  void showProgressDialog(BuildContext context, String status) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return ProgressDialog(status: status);
    },
  );
}

  void handleUploadDocuments() async {
  if (applicantid != null) {
    showProgressDialog(context, 'Uploading documents...'); // Show progress dialog

    bool success = await DocumentUploadService.uploadDocuments(applicantid!, selectedFiles, customFileNames);

    Navigator.of(context).pop(); // Hide progress dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Document Upload Result'),
          content: Text(success ? 'Documents uploaded successfully!' : 'Failed to upload documents.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Document'),
          leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pushReplacementNamed(context, AppRouteName.jobSeekerNavigation);
    },
  ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (applicantid != null)
                Text('Application ID: $applicantid', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              buildFilePickerButton('Passport Front', 'passportFront'),
              buildFilePickerButton('Passport Back', 'passportBack'),
              buildFilePickerButton('passportFull', 'passportFull'),
              buildFilePickerButton('Experience', 'experience'),
              buildFilePickerButton('Highest Qualification ', 'highestQualification'),
              buildFilePickerButton('Technical Qualification Optional', 'technicalQualification'),
         
          
              buildFilePickerButton('Full Length Photo', 'fullLengthPhoto'),
              buildFilePickerButton('Passport Size Photo', 'passportSizePhoto'),
              buildFilePickerButton('V Certificate', 'vCertificate'),
              buildFilePickerButton('Other Document 1', 'other1'),
              buildFilePickerButton('Other Document 2', 'other2'),
              buildFilePickerButton('Other Document 3', 'other3'),
              buildFilePickerButton('Other Document 4', 'other4'),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: handleUploadDocuments,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                ),
                icon: const Icon(
                  Icons.upload_file_sharp,
                  size: 15,
                  color: Colors.white,
                ),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Text('Upload Documents'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFilePickerButton(String label, String field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () => pickFile(field),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              ),
              icon: const Icon(
                Icons.upload_file_sharp,
                size: 15,
                color: Colors.white,
              ),
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Text(
                  'Upload $label',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 5),
        if (selectedFileNames[field] != null)
          Text(
            'Selected: ${selectedFileNames[field]}',
            style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 10, 9, 9)),
            overflow: TextOverflow.ellipsis,
          ),
        if (field.startsWith('other') && customFileNames[field] != null)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              'Custom name: ${customFileNames[field]}',
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }
}
