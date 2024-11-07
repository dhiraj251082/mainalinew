import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mainalihr/main.dart'; // Import your main.dart or MyApp file here

class RegisterService {
  static Future<void> register(BuildContext context, {
    required TextEditingController applicantIdController,
    required TextEditingController applicantNameController,
    required TextEditingController fatherSpouseNameController,
    required DateTime? selectedDOB,
    required String? selectedGender,
    required String? selectedMaritalStatus,
    required TextEditingController contactNumberController,
    required TextEditingController whatsappController,
    required TextEditingController emailController,
    required TextEditingController heightController,
    required TextEditingController weightController,
    required TextEditingController addressLine1Controller,
    required TextEditingController addressLine2Controller,
    required TextEditingController pincodeController,
    required TextEditingController districtController,
    required TextEditingController stateController,
    required TextEditingController countryController,
    required TextEditingController passportNoController,
    required DateTime? selectedPassportExpiry,
  }) async {
    String errorMessage = '';

    try {
      DateTime dob = selectedDOB ?? DateTime.now();
      DateTime passportExpiry = selectedPassportExpiry ?? DateTime.now();

      String formattedDOB =
          '${dob.year}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}';
      String formattedPassportExpiry =
          '${passportExpiry.year}-${passportExpiry.month.toString().padLeft(2, '0')}-${passportExpiry.day.toString().padLeft(2, '0')}';
      String dynamicEndpoint = MyApp.generateEndpoint("api/register");
      
      final response = await http.post(
        Uri.parse(dynamicEndpoint),
        body: {
          'applicant_id': applicantIdController.text,
          'applicant_name': applicantNameController.text,
          'fatherspourse_name': fatherSpouseNameController.text,
          'dob': formattedDOB,
          'gender': selectedGender ?? '',
          'marital_status': selectedMaritalStatus ?? '',
          'customer_phoneno': contactNumberController.text,
          'customer_whatsapp': whatsappController.text,
          'customer_email': emailController.text,
          'height': heightController.text,
          'weight': weightController.text,
          'present_address1': addressLine1Controller.text,
          'present_address2': addressLine2Controller.text,
          'present_pin': pincodeController.text,
          'district': districtController.text,
          'state': stateController.text,
          'country': countryController.text,
          'passport_no': passportNoController.text,
          'passport_expiry_date': formattedPassportExpiry,
          // Add other fields here...
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: Text(responseData['message2']),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        final responseData = json.decode(response.body);
        errorMessage = responseData['message2'] ?? 'Registration failed';
      }
    } catch (error) {
      errorMessage = 'Error: $error';
    }

    if (errorMessage.isNotEmpty) {
      // Display error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
