import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mainalihr/main.dart';
import 'package:mainalihr/model/DocumentModel.dart';

class DocumentUploadService {
  static Future<bool> uploadDocuments(String applicantId, Map<String, File?> selectedFiles, Map<String, String?> customFileNames) async {
    final dynamicEndpoint = MyApp.generateEndpoint("api/apistore-documents");

    DocumentModel document = DocumentModel(
      applicationId: applicantId,
      passportFront: selectedFiles['passportFront'],
      passportBack: selectedFiles['passportBack'],
      passportFull: selectedFiles['passportFull'],
      technicalQualification: selectedFiles['technicalQualification'],
      experience: selectedFiles['experience'],
      highestQualification: selectedFiles['highestQualification'],
      fullLengthPhoto: selectedFiles['fullLengthPhoto'],
      passportSizePhoto: selectedFiles['passportSizePhoto'],
      vCertificate: selectedFiles['vCertificate'],
      other1: selectedFiles['other1'],
      otherName1: customFileNames['other1'] ?? '',
      other2: selectedFiles['other2'],
      otherName2: customFileNames['other2'] ?? '',
      other3: selectedFiles['other3'],
      otherName3: customFileNames['other3'] ?? '',
      other4: selectedFiles['other4'],
      otherName4: customFileNames['other4'] ?? '',
    );

    var request = http.MultipartRequest('POST', Uri.parse(dynamicEndpoint));
    request.fields['application_id'] = document.applicationId;

    // List to collect missing file messages
    List<String> missingFilesMessages = [];

    // Add files to the request
    if (document.passportFront != null) {
      request.files.add(await http.MultipartFile.fromPath('passport_front', document.passportFront!.path));
    } else {
      missingFilesMessages.add('Passport Front is missing.');
    }

    if (document.passportBack != null) {
      request.files.add(await http.MultipartFile.fromPath('passport_back', document.passportBack!.path));
    } else {
      missingFilesMessages.add('Passport Back is missing.');
    }

    if (document.passportFull != null) {
      request.files.add(await http.MultipartFile.fromPath('passportFull', document.passportFull!.path));
    } else {
      missingFilesMessages.add('Passport Full is missing.');
    }

    if (document.technicalQualification != null) {
      request.files.add(await http.MultipartFile.fromPath('technical_qualification', document.technicalQualification!.path));
    } else {
      missingFilesMessages.add('Technical Qualification is missing.');
    }

    if (document.experience != null) {
      request.files.add(await http.MultipartFile.fromPath('experience', document.experience!.path));
    } else {
      missingFilesMessages.add('Experience is missing.');
    }

    if (document.highestQualification != null) {
      request.files.add(await http.MultipartFile.fromPath('highest_qualification', document.highestQualification!.path));
    } else {
      missingFilesMessages.add('Highest Qualification is missing.');
    }

    if (document.fullLengthPhoto != null) {
      request.files.add(await http.MultipartFile.fromPath('full_length_photo_size', document.fullLengthPhoto!.path));
    } else {
      missingFilesMessages.add('Full Length Photo is missing.');
    }

    if (document.passportSizePhoto != null) {
      request.files.add(await http.MultipartFile.fromPath('passport_size_photo', document.passportSizePhoto!.path));
    } else {
      missingFilesMessages.add('Passport Size Photo is missing.');
    }

    if (document.vCertificate != null) {
      request.files.add(await http.MultipartFile.fromPath('v_certificate', document.vCertificate!.path));
    } else {
      missingFilesMessages.add('V Certificate is missing.');
    }

    if (document.other1 != null) {
      request.files.add(await http.MultipartFile.fromPath('other1', document.other1!.path));
      request.fields['otherName1'] = document.otherName1;
    } else {
      missingFilesMessages.add('Other Document 1 is missing.');
    }

    if (document.other2 != null) {
      request.files.add(await http.MultipartFile.fromPath('other2', document.other2!.path));
      request.fields['otherName2'] = document.otherName2;
    } else {
      missingFilesMessages.add('Other Document 2 is missing.');
    }

    if (document.other3 != null) {
      request.files.add(await http.MultipartFile.fromPath('other3', document.other3!.path));
      request.fields['otherName3'] = document.otherName3;
    } else {
      missingFilesMessages.add('Other Document 3 is missing.');
    }

    if (document.other4 != null) {
      request.files.add(await http.MultipartFile.fromPath('other4', document.other4!.path));
      request.fields['otherName4'] = document.otherName4;
    } else {
      missingFilesMessages.add('Other Document 4 is missing.');
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Documents uploaded successfully');
      if (missingFilesMessages.isNotEmpty) {
        print('The following files are missing:');
        for (var message in missingFilesMessages) {
          print(message);
        }
      }
      return true;
    } else {
      print('Failed to upload documents');
      if (missingFilesMessages.isNotEmpty) {
        print('The following files are missing:');
        for (var message in missingFilesMessages) {
          print(message);
        }
      }
      return false;
    }
  }
}
