import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/main.dart';
import 'package:mainalihr/model/UserCredentials.dart';
import 'package:provider/provider.dart';


class LoginUtil {
  static Future<void> login(BuildContext context, UserCredentials credentials) async {
    // Convert UserCredentials object to JSON
    String jsonBody = json.encode(credentials.toJson());
     String dynamicEndpoint = MyApp.generateEndpoint("api/Apilogin");
     print(dynamicEndpoint);

    // Send username and password for authentication
    final response = await http.post(
      Uri.parse(dynamicEndpoint), // URL for authentication
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );

    // Check if request was successful
    if (response.statusCode == 200) {
       Map<String, dynamic> responseData = json.decode(response.body);

      // Extract user details from the response
      String? userId = responseData['user']['user_id'];
      String? role = responseData['user']['role'];
      String? name = responseData['user']['name'];
      String? email = responseData['user']['email'];
      print('User ID: $userId');
print('Role: $role');
print('Name: $name');
//fluttprint('Email: $email');

      // Update user credentials with the fetched data
      credentials.userId = userId;
      credentials.role = role;
      credentials.name = name;
      credentials.email = email;
      // Successful authentication
      showMessage(context, 'Login successful!');


//UserProvider userProvider = UserProvider(); // Create an instance of UserProvider

UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
UserCredentials updatedCredentials = userProvider.updateUserCredentials(credentials);
    

if (role == "jobseeker"  || role=="admin") {
  Navigator.pushReplacementNamed(context, AppRouteName.jobSeekerNavigation);
}
if(role == "client" || role=="admin"){
          Navigator.pushReplacementNamed(context, AppRouteName.clientNavigation);
}

 
   } else {
      // Authentication failed
      showMessage(context, 'Login failed. Please try again.');
    }
  }

  static bool isEmail(String input) {
    // Simple email validation
    String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    return RegExp(emailRegex).hasMatch(input);
  }

  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
