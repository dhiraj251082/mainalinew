import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:mainalihr/main.dart';
import 'package:mainalihr/model/CompleteJobSeekerModel.dart';
import 'package:mainalihr/model/JobApplyModel.dart';
import 'package:mainalihr/model/JobPostingModel.dart';
import 'package:mainalihr/model/JobSeekerModel.dart';
import 'package:mainalihr/model/UserModel.dart';
class ApplicantDetails {
  final JobSeekerModel jobSeeker;
final List<JobApply> jobApplies;
  final List<JobPostingModel> jobPostings;

  ApplicantDetails({
    required this.jobSeeker,
   required this.jobApplies,
    required this.jobPostings,
  });
}
class ClientDetails {
  final UserModel user;
final List<JobApply> jobApplies;
  final List<JobPostingModel> jobPostings;

  ClientDetails({
    required this.user,
   required this.jobApplies,
    required this.jobPostings,
  });
}


int generateSimpleInteger() {
  Random random = Random();
  String firstDigit = (random.nextInt(9) + 1).toString(); // Generate a random digit between 1 and 9
  String restDigits = ''; // Generate 9 random digits
  for (int i = 0; i < 9; i++) {
    restDigits += random.nextInt(10).toString();
  }
  return int.parse(firstDigit + restDigits);
}


class SearchService {

  //the below code will provide the jobseeker details which 
  //is selected by client with age profession and gender from the form _SearchJobSeekerState

 static Future<List<CompleteJobSeekerModel>> sendSearchData(String jsonData) async {

  // Construct your URL
 try {
    // Generate the dynamic endpoint for fetching job seekers
    String dynamicEndpoint = MyApp.generateEndpoint("api/ApiSearch1");
    print("Dynamic Endpoint: $dynamicEndpoint");
    print('JSON Data to be sent: $jsonData');

    // Make the HTTP POST request with the provided JSON data
    final response = await http.post(
      Uri.parse(dynamicEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonData, // Send the JSON data as the body
    );

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Parse the response body as JSON
      final jsonResponse = json.decode(response.body);
      final List<dynamic> jobSeekersJson = jsonResponse['jobSeekers'];

      // Log the fetched data for debugging
      print('Fetched Job Seekers Data: $jobSeekersJson');

      // Map the JSON data to a list of CompleteJobSeekerModel objects
      List<CompleteJobSeekerModel> jobSeekers = jobSeekersJson
          .map((json) => CompleteJobSeekerModel.fromJson(json))
          .toList();

      // Log the parsed job seekers list
      print('Parsed Job Seekers List: $jobSeekers');

      // Return the list of job seekers
      return jobSeekers;
    } else {
      // Handle unexpected status codes
      throw Exception('Failed to load job seekers. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Catch any errors that occur during the request or parsing process
    print('Error fetching job seekers: $e'); // Log the error for debugging
    throw Exception('Failed to load job seekers. Please try again later.');
  }
  }
  


                         




  //in this code i am sending the selected Cantidate with the search Criteria mention by the client with genration of demand ID
 static Future<ApiResponse> submitSelectedApplicants(String userid, String username,String clientname,String role, List<int> selectedApplicantIds, Map<String, dynamic> searchData) async {
    // Construct payload with selected data and additional information
      String dynamicEndpoint = MyApp.generateEndpoint("api/selected-applicants");

       int simpleInteger = generateSimpleInteger();
  print(simpleInteger);

   
    Map<String, dynamic> postData = {
      'applicant_ids': selectedApplicantIds,
      'userid': userid,
      'uniquejobid':simpleInteger,
        'client_name': clientname,
      'username': username,
      'gender': searchData['gender'],
      'min_age': searchData['minAge'],
      'max_age': searchData['maxAge'],
      'professions': searchData['professions'],
      'role':role,
    };
    String jsonData = json.encode(postData);
      print('Data to be sent: $jsonData and url is $dynamicEndpoint ');

    // Make POST request
    try {
      final response = await http.post(
        Uri.parse(dynamicEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Selected applicants submitted successfully');
         return ApiResponse(success: true, message: 'Candidates Shorlisted Successfully.Our Team will reach you shortly');
      } else {
        // Handle error
        print('Failed to submit selected applicants. Status code: ${response.statusCode}');
         return ApiResponse(success: false, message: 'Failed to Shortlist Candidates Conatact Mainali Hr. ');
      }
    } catch (e) {
      // Handle error
      print('Error submitting selected applicants: $e');
      return ApiResponse(success: false, message: 'Failed to Shortlist Candidates Conatact Mainali Hr.');
    }
  }


 //in this code i am sending the selected Candida without the Criteria mention by the client with genration of demand ID
  static Future<ApiResponse> submitSelectedApplicants2(String userid, String username,String clientname,String role, List<int> selectedApplicantIds) async {
    // Construct payload with selected data and additional information
      String dynamicEndpoint = MyApp.generateEndpoint("api/selected-applicants");

       int simpleInteger = generateSimpleInteger();
  print(simpleInteger);

   
    Map<String, dynamic> postData = {
      'applicant_ids': selectedApplicantIds,
      'userid': userid,
      'uniquejobid':simpleInteger,
        'client_name': clientname,
      'username': username,
      
      'role':role,
    };
    String jsonData = json.encode(postData);
      print('Data to be sent: $jsonData and url is $dynamicEndpoint ');

    // Make POST request
    try {
      final response = await http.post(
        Uri.parse(dynamicEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Selected applicants submitted successfully');
         return ApiResponse(success: true, message: 'Demand Created Successully.');
      } else {
        // Handle error
        print('Failed to submit selected applicants. Status code: ${response.statusCode}');
         return ApiResponse(success: false, message: 'Demand Not Created Contant Mainali Hr.');
      }
    } catch (e) {
      // Handle error
      print('Error submitting selected applicants: $e');
      return ApiResponse(success: false, message: 'Demand Not Created Contant Mainali Hr.');
    }
  }



  static Future<List<Map<String, dynamic>>> fetchSelectedApplicants() async {
  String dynamicEndpoint = MyApp.generateEndpoint("api/fetchenquiry");
  final url = Uri.parse(dynamicEndpoint);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> applicantsData = json.decode(response.body);
   //  print(applicantsData);
      
    // Directly return the list of applicants without grouping
    
    return List<Map<String, dynamic>>.from(applicantsData);
  } else { 
    throw Exception('Failed to fetch selected applicants');
  }

}



//This shows to the Job seeker the job he had applied
static Future<ApplicantDetails> fetchApplicantDetails(String userid) async {

String dynamicEndpoint = MyApp.generateEndpoint("api/getApplicantDetails/$userid");
  final url = Uri.parse(dynamicEndpoint);

  
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
              
      final String responseBody = response.body;


      if (responseBody.isNotEmpty) {
        final Map<String, dynamic> data = jsonDecode(responseBody);
        final jobSeeker = JobSeekerModel.fromJson(data['jobSeeker']);
       final jobApplies = (data['jobApplies'] as List<dynamic>).map((e) => JobApply.fromJson(e)).toList();
        final jobPostings = (data['jobPostings'] as List<dynamic>).map((e) => JobPostingModel.fromJson(e)).toList();
        return ApplicantDetails(
          jobSeeker: jobSeeker,
         jobApplies: jobApplies,
         jobPostings: jobPostings,
        );
      } else {
        throw Exception('Response body is empty');
      }
    } else {
      throw Exception('Failed to load applicant details. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // It's a good practice to log errors
print('Error fetching data: $e');
    rethrow; // Use 'rethrow' to preserve the stack trace of the exception
  }
}



// this code will show the details for the Demand given by the client
static Future<ClientDetails> fetchdemands(String userid) async {
  
      
  


  String dynamicEndpoint = MyApp.generateEndpoint("api/fetchdemands/$userid");
  final url = Uri.parse(dynamicEndpoint);

  
 
  
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final String responseBody = response.body;
      if (responseBody.isNotEmpty) {
        final Map<String, dynamic> data = jsonDecode(responseBody);
        final user = UserModel.fromJson(data['user']);
        print("the data $data");
        // Check for null before casting to a list
       final jobApplies = (data['jobApplications'] != null)
    ? (data['jobApplications'] as List<dynamic>).map((e) => JobApply.fromJson(e)).toList()
    : <JobApply>[];
        final jobPostings = (data['jobPostings'] != null) ? 
        (data['jobPostings'] as List<dynamic>).map((e) => JobPostingModel.fromJson(e)).toList() 
        : <JobPostingModel>[];

        return  ClientDetails(
          user: user,
          jobApplies: jobApplies,
          jobPostings: jobPostings,
        );
      } else {
        throw Exception('Response body is empty');
      }
    } else {
      throw Exception('Failed to load applicant details. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // It's a good practice to log errors
    print('Error fetching data: $e');
    rethrow; // Use 'rethrow' to preserve the stack trace of the exception
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