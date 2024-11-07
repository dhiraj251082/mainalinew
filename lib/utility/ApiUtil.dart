// api_util.dart
// api_util.dart

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mainalihr/main.dart';
import 'package:mainalihr/model/JobPostingModel.dart';
import 'package:mainalihr/model/Location_currency_model.dart';
import 'package:mainalihr/model/education_model.dart';
import 'package:mainalihr/model/experience_model.dart';
import 'package:mainalihr/model/industry_model.dart';
import 'package:mainalihr/model/profession_model.dart';
class ApiUtil {


    static final http.Client _client = http.Client();
  
  static Future<ApiResponse> submitAllExperience(List<Experience> experienceRecords) async {
        String dynamicEndpoint = MyApp.generateEndpoint("api/experienceapi");
    print("adding experience");

     List<Map<String, dynamic>> recordsJson = experienceRecords.map((e) => e.toJson()).toList();
  print("Payload being sent: $recordsJson");
    
    final response = await http.post(
      Uri.parse(dynamicEndpoint),
      body: json.encode({'experienceRecords': experienceRecords.map((e) => e.toJson()).toList()}),
      headers: {'Content-Type': 'application/json'},
    );

     if (response.statusCode == 200) {
    // Decode the JSON response and create an ApiResponse object
    final responseData = json.decode(response.body);
    return ApiResponse(success: true, message: 'Education Inserted Successfully.');
  } else {
    // Return an ApiResponse with 'success' set to false
    return ApiResponse(success: false, message: 'Registration failed. Please try again.');
  }
  }
  


  static Future<void> submitAllJobPosting(List<JobPostingModel> JobpostingRecords) async {
        String dynamicEndpoint = MyApp.generateEndpoint("api/storejobposting");

    final encodedData = json.encode({'jobpostingRecords': JobpostingRecords.map((e) => e.toJson()).toList()});
    print('Sending data to server: $encodedData');
    final response = await http.post(
      Uri.parse(dynamicEndpoint),
      body: encodedData,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Job Posting added successfully');
    } else {
      print('Failed to add Job Posting records');

       // Check if there is an error message in the response body
  if (response.body.isNotEmpty) {
    // Parse the error message from the response body
    final Map<String, dynamic> responseData = json.decode(response.body);
    final errorMessage = responseData['error'];
    print('Error message from server: $errorMessage');
  }
    }
  }


  static Future<ApiResponse> submitAllEducation(List<Education> educationRecords) async {
        String dynamicEndpoint = MyApp.generateEndpoint("api/educationapi");

       print("newone");

    
    final response = await http.post(
      Uri.parse(dynamicEndpoint),
      body: json.encode({'educationRecords': educationRecords.map((e) => e.toJson()).toList()}),
      headers: {'Content-Type': 'application/json'},
    );

     if (response.statusCode == 200) {
    // Decode the JSON response and create an ApiResponse object
    final responseData = json.decode(response.body);
    return ApiResponse(success: true, message: 'Education Inserted Successfully.');
  } else {
    // Return an ApiResponse with 'success' set to false
    return ApiResponse(success: false, message: 'Registration failed. Please try again.');
  }
  }

  

   Future<List<Profession>> fetchAllProfessions() async {
  String dynamicEndpoint = MyApp.generateEndpoint("api/fetch-professions");

  try {
    final response = await http.get(Uri.parse(dynamicEndpoint));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Profession> professions = data.map((json) => Profession.fromJson(json)).toList();
      
      return professions;
    } else {
      print('Failed to load professions');
      throw Exception('Failed to load professions');
    }
  } catch (e) {
    print('Error fetching professions: $e');
    throw Exception('Failed to load professions');
  }
}



   Future<List<Industry>> fetchIndustries() async {
        String dynamicEndpoint = MyApp.generateEndpoint("api/fetch-industries");



  try {
    final response = await http.get(Uri.parse(dynamicEndpoint));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((json) => Industry.fromJson(json)).toList();
    } else {
      print('Failed to load industries. Status code: ${response.statusCode}');
      throw Exception('Failed to load industries');
    }
  } catch (e) {
    print('Error fetching industries: $e');
    throw Exception('Failed to load industries');
  }
}



Future<List<Location>> fetchLocations() async {
     String dynamicEndpoint = MyApp.generateEndpoint("api/fetch-locations");





  try {
    final response = await http.get(Uri.parse(dynamicEndpoint));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((json) => Location.fromJson(json)).toList();
    } else {
      print('Failed to load locations. Status code: ${response.statusCode}');
      throw Exception('Failed to load lcoation');
    }
  } catch (e) {
    print('Error fetching locations: $e');
    throw Exception('Failed to load locations');
  }
}


//fetch all job seekeras
 

// uploading the documents


static Future<bool> uploadDocuments({
    required String apiUrl,
    required String applicationId,
    File? passportFront,
    File? passportBack,
    File? passportFull,
    File? technicalQualification,
    File? experience,
    File? highestQualification,
    File? fullLengthPhoto,
    File? passportSizePhoto,
    File? vCertificate,
    File? other1,
    String? otherName1,
    File? other2,
    String? otherName2,
    File? other3,
    String? otherName3,
    File? other4,
    String? otherName4,
    // Add parameters for other document fields
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));       
  /* print('Application ID: $applicationId');
     print('URL: $apiUrl');
  
  print('passportFront in ApiUtil: ${passportFront?.path}');

      print('Passport Back: ${passportBack?.path}');
      print('Passport Full: ${passportFull?.path}');
      print('Highest Qualification: ${highestQualification?.path}');
      print('Full Length Photo: ${fullLengthPhoto?.path}');
      print('Passport Size: ${passportSizePhoto?.path}');
      
     print('technicalQualification: ${technicalQualification?.path}');
      
      print('V Certificate: ${vCertificate?.path}');
       print('other1: ${other1?.path}');
              print('othername1: $otherName1');
      print('other2: ${other2?.path}');
        print('othername2: $otherName2');*/



      request.fields['application_id'] = applicationId;

      request.files.add(
        await http.MultipartFile.fromPath('passport_front', passportFront?.path ?? ''),
      );

      request.files.add(
        await http.MultipartFile.fromPath('passport_back', passportBack?.path ?? ''),
      );

      request.files.add(
        await http.MultipartFile.fromPath('passport_full', passportFull?.path ?? ''),
      );

      request.files.add(
        await http.MultipartFile.fromPath('highest_qualification', highestQualification?.path ?? ''),

      );
       request.files.add(
        await http.MultipartFile.fromPath('technical_qualification', technicalQualification?.path ?? ''),
        
      );

      request.files.add(
        await http.MultipartFile.fromPath('full_length_photo', fullLengthPhoto?.path ?? ''),
      );
        request.files.add(
        await http.MultipartFile.fromPath('passport_size_photo', passportSizePhoto?.path ?? ''),
      );

      request.files.add(
        await http.MultipartFile.fromPath('v_certificate', vCertificate?.path ?? ''),
      );

      request.files.add(
        await http.MultipartFile.fromPath('experience', experience?.path ?? ''),
      );
if (other2 != null) {
  request.files.add(
    await http.MultipartFile.fromPath('other2', other2.path),
  );
}
if (other1 != null) {
  request.files.add(
    await http.MultipartFile.fromPath('other1', other1.path),
  );
}
if (other3 != null) {
  request.files.add(
    await http.MultipartFile.fromPath('other3', other3.path),
  );
}
if (other4 != null) {
  request.files.add(
    await http.MultipartFile.fromPath('other4', other4.path),
  );
}

      
request.fields['otherName1'] = otherName1 ?? '';
request.fields['otherName2'] = otherName2 ?? '';
request.fields['otherName3'] = otherName3 ?? '';
request.fields['otherName4'] = otherName4 ?? '';




      // Add multipart files for other document fields
      // Ensure to handle names and files for other fields in a similar way

      var response = await _client.send(request);

      if (response.statusCode == 200) {
        // Document uploaded successfully
        return true;
      } else if(response.statusCode == 404) {
        print('API endpoint not found');
      } else if (response.statusCode == 401) {
        print('Unauthorized request');
      } else {
        print('API error: ${response.reasonPhrase}');
      }
      return false;
      
    } catch (e) {
      if (e is SocketException) {
        print('Network error: $e');
      } else if (e is FormatException) {
        print('Error parsing JSON: $e');
      } else {
        print('Unexpected error: $e');
      }
      return false;
    }
  }
      

}

  class ApiResponse {
  final bool success;
  final String message;

  ApiResponse({required this.success, required this.message});

  // Factory constructor to create an ApiResponse from a JSON map
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}