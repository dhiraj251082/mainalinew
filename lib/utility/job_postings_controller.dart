import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mainalihr/main.dart';
import 'package:mainalihr/model/JobPostingModel.dart';

class JobPostingsController {
  List<JobPostingModel>? _allJobPostings;

  Future<List<JobPostingModel>> fetchJobPostings() async {
    print("\nwihout searching contoller\n");
    if (_allJobPostings != null) {

      return _allJobPostings!;
    }


    String dynamicEndpoint = MyApp.generateEndpoint("api/latestjob");
     //  print("dynamic end point $dynamicEndpoint");
     

    final response = await http.get(Uri.parse(dynamicEndpoint));

    if (response.statusCode == 200) {

      final jsonData = json.decode(response.body);
      final List<dynamic> jobPostingsJson = jsonData['jobPostings'];
      //print(jobPostingsJson);

      _allJobPostings = jobPostingsJson.map((json) => JobPostingModel(

    //    jobId: json['job_id'],
  companyName: json['company_name'],
  jobTitle: json['job_title'],
   locationName: json['location_name'],
   locationid:json['location_id'],
   industryid: json['industry_id'],
       jobId: json['job_id'],
 
     
        industryName: json['industry_id'],
        professionName: json['profession_name'],
        jobDescription: json['job_description'],
        


        salary: json['salary'],
        minimumQualification: json['minimum_qualification'],
        gender: json['gender'],
        minAge: json['min_age'],
        maxAge: json['max_age'],
        accomodation: json['accomodation'],
        food: json['food'],
        interviewdate: json['interviewdate'],
        transport: json['transport'],
      )).toList();
  
   
      return _allJobPostings!;
    } else {

      throw Exception('Failed to load job postings');
    }
  }

 Future<List<JobPostingModel>> filterJobPostings() async {
     print("\n\n\tin filter 1");
   
  // Check if job postings have been fetched
  if (_allJobPostings == null) {
    // Fetch job postings if not fetched yet
    await fetchJobPostings();
    
  }


  // If job postings are still null, throw an exception
  if (_allJobPostings == null) {
    //print("i am null _All Job posing");

    throw Exception('Job postings not fetched yet');
  }
/*print("_allJobPostings:this is filter job not 2");
  _allJobPostings!.forEach((jobPosting) {
    print("Job ID: ${jobPosting.jobId}");
    print("Company Name: ${jobPosting.companyName}");
    //print("Job Title: ${jobPosting.jobTitle}");
      print("Industry id: ${jobPosting.industryName}");
      print("location id: ${jobPosting.location_id}");
            print("location name: ${jobPosting.locationName}");
    // Add more properties as needed
  });
  print("outside");*/
  List<JobPostingModel> filteredList = _allJobPostings!;


  return filteredList;
}

Future<List<JobPostingModel>> filterJobPostings2(String? industry, String? location) async {
print("\n\nin filter 2");
   
  // Check if job postings have been fetched
  if (_allJobPostings == null) {
    //print("sub on workiing inside beinging filtered");
    // Fetch job postings if not fetched yet
    await fetchJobPostings();
    
  }


  // If job postings are still null, throw an exception
  if (_allJobPostings == null) {
    throw Exception('Job postings not fetched yet');
  }
/*print("_allJobPostings:");
  _allJobPostings!.forEach((jobPosting) {
    print("Job ID: ${jobPosting.jobId}");
    print("Company Name: ${jobPosting.companyName}");
          print("Industry id: ${jobPosting.industryid}");
    //print("Job Title: ${jobPosting.jobTitle}");
      print("Industry id: ${jobPosting.industryName}");
      print("location id: ${jobPosting.locationid}");
    // Add more properties as needed
  });*/


List<JobPostingModel> filteredList = _allJobPostings!;
print("\n\nFiltered List:");
for (var jobPosting in filteredList) {
   print("\n\n");
  print(jobPosting); // This will print each JobPostingModel object with its properties
}

   print("\n\n");


  if (industry != null) {
    
    //print("this is a selected industry $industry");
   // print("selected industry:  $industry");
     //   print("hello world");
      //print("Industry id inside : $industry");
    filteredList = filteredList.where((jobPosting) => jobPosting.industryid == industry).toList();

  }

       print("select industry $industry and selected location $location");
         print("\n\n");
  if (industry != null && location != null) {

  filteredList = filteredList.where((jobPosting) => 
    jobPosting.industryid == industry && jobPosting.locationid == location
  ).toList();
} 

 // if (location != null) {
 //   filteredList = filteredList.where((jobPosting) => jobPosting.locationName == location).toList();
//  }

print("\n\nFiltered Job Postings Length: ${filteredList.length}");

for (var jobPosting in filteredList) {
  print("\n\n");
  print("\nJob ID: ${jobPosting.jobId}");
  print("\nCompany Name: ${jobPosting.companyName}");
  print("\nJob Title: ${jobPosting.jobTitle}");
   print("\nlocation id: ${jobPosting.locationid}");
  // Print other properties as needed
}
  return filteredList;
}

  Future<ApiResponse> sendApplication(String applicationId, String jobId) async {
    String dynamicEndpoint = MyApp.generateEndpoint("api/postjobapply");

    // Construct the request body with application ID and job ID
    Map<String, dynamic> requestBody = {
      'application_id': applicationId,
      'job_id': jobId,
    };

    // Make an HTTP POST request to send application data to the server
    var response = await http.post(
      Uri.parse(dynamicEndpoint),
      body: requestBody,
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Application sent successfully
      print('Application sent successfully');
 return ApiResponse(success: true, message: 'Job Applied Successfully.');
    } else {
      // Error occurred while sending application
      print('Error in server: ${response.reasonPhrase}');
       return ApiResponse(success: false, message: 'Failure in Job Application Contact Mainali HR.');
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
