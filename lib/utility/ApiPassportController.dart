import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mainalihr/main.dart';

class ApiPassportController {




  Future<Map<String, dynamic>> searchByPassportNumber(String passportNumber) async {
            String dynamicEndpoint = MyApp.generateEndpoint("api/search-records?passport_number=$passportNumber");
      try {
      final response = await http.get(Uri.parse(dynamicEndpoint));
      print("Request URL: $dynamicEndpoint"); // Print the URL for debugging
      
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print("Response Data: $responseData"); // Print the response data
        return responseData; // Return the decoded JSON response
      } else {
        print("Error: ${response.statusCode}"); // Print the error status code
        return {'message': 'No passport found'};
      }
    } catch (e) {
      print("Failed to fetch record: $e"); // Print any errors that occur during the request
      return {'message': 'Failed to fetch record'};
    }
  }
}
