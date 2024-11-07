import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mainalihr/main.dart';
import 'package:mainalihr/model/CompleteJobSeekerModel.dart'; // Updated import to use the new model

class JobSeekerController {
  // Fetch all job seekers with images
  Future<List<CompleteJobSeekerModel>> fetchJobSeekers() async {
    try {
      // Generate the dynamic endpoint for fetching job seekers
      String dynamicEndpoint = MyApp.generateEndpoint("api/getCompleteJobSeekers");

      // Make the HTTP GET request
      final response = await http.get(Uri.parse(dynamicEndpoint));

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // Parse the response body as JSON
        final jsonData = json.decode(response.body);
        final List<dynamic> jobSeekersJson = jsonData['jobSeekers'];

        // Log the fetched data for debugging
        print('Fetched Job Seekers Data: $jobSeekersJson');

        // Map the JSON data to a list of CompleteJobSeekerModel objects using the fromJson method
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
}
