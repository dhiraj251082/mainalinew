import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/main.dart';
import 'package:mainalihr/widgets/ProgressDialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});


  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class ApplicantIDGenerator {
  static String generateApplicantID() {
    DateTime now = DateTime.now();
    String year = DateFormat('yyyy').format(now);
    String month = DateFormat('MM').format(now);
    String day = DateFormat('dd').format(now);
    String hours = DateFormat('HH').format(now);
    String minutes = DateFormat('mm').format(now);
    String seconds = DateFormat('ss').format(now);

    String applicantID = '$year$month$day$hours$minutes$seconds';

    return applicantID;
   }
  }

 class _RegisterPageState extends State<RegisterPage> {
  DateTime? _selectedDOB; // Variable to store the selected Date of Birth
  DateTime? _selectedPassportExpiry;
   bool _isLoading = false;

  String? _selectedGender;
  String? _selectedMaritalStatus;

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDOB) {
      setState(() {
       // _selectedDOB = picked;

         _selectedDOB = DateTime(picked.year, picked.month, picked.day);
        // Update the _dobController text when date is selected
      //  _dobController.text = '25/10/1983';
      _dobController.text = DateFormat('dd/MM/yyyy').format(_selectedDOB!);
        //'${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  Future<void> _selectPassportExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (picked != null) {
      setState(() {
        _selectedPassportExpiry = picked;
        _passportExpiryDateController.text ='25/10/2028';
         //   '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  Widget buildMaritalStatusDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Marital Status',
        border: OutlineInputBorder(),
      ),
      value: _selectedMaritalStatus,
      onChanged: (String? newValue) {
        setState(() {
          _selectedMaritalStatus = newValue;
        });
      },
      items: <String>['Single', 'Married', 'Divorce']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value.toLowerCase(),
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select marital status';
        }
        return null;
      },
    );
  }

  Widget buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(),
      ),
      value: _selectedGender,
      onChanged: (String? newValue) {
        setState(() {
          _selectedGender =  newValue;
        });
      },
      items: <String>['', 'Male', 'Female', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value.isNotEmpty ? value.toLowerCase() : null,
          child: Text(value),
        );
      }).toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select gender';
        }
        return null;
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _applicantIdController = TextEditingController();
  final TextEditingController _applicantNameController =
      TextEditingController();
  final TextEditingController _fatherSpouseNameController =
      TextEditingController();

  final TextEditingController _genderController = TextEditingController();

  final TextEditingController _contactNumberController =
      TextEditingController();

  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _passportNoController = TextEditingController();
  final TextEditingController _passportExpiryDateController =
      TextEditingController();

  String _errorMessage = '';
  String applicantID = ApplicantIDGenerator.generateApplicantID();

 Future<void> _register() async {
  setState(() {
    _errorMessage = '';
      _isLoading = true;

  });
  
    showProgressDialog(context, 'Processing...');

  try {
    DateTime dob = _selectedDOB ?? DateTime.now();
    DateTime passportExpiry = _selectedPassportExpiry ?? DateTime.now();

    String formattedDOB =
        '${dob.year}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}';
    String formattedPassportExpiry =
        '${passportExpiry.year}-${passportExpiry.month.toString().padLeft(2, '0')}-${passportExpiry.day.toString().padLeft(2, '0')}';
    String dynamicEndpoint = MyApp.generateEndpoint("api/register");
    
    final response2 = await http.post(
      Uri.parse(dynamicEndpoint),
      body: {
        'applicant_id': _applicantIdController.text,
        'applicant_name': _applicantNameController.text,
        'fatherspourse_name': _fatherSpouseNameController.text,
        'dob': formattedDOB,
        'gender': _selectedGender ?? '',
        'marital_status': _selectedMaritalStatus ?? '',
        'customer_phoneno': _contactNumberController.text,
        'customer_whatsapp': _whatsappController.text,
        'customer_email': _emailController.text,
        'height': _heightController.text,
        'weight': _weightController.text,
        'present_address1': _addressLine1Controller.text,
        'present_address2': _addressLine2Controller.text,
        'present_pin': _pincodeController.text,
        'district': _districtController.text,
        'state': _stateController.text,
        'country': _countryController.text,
        'passport_no': _passportNoController.text,
        'passport_expiry_date': formattedPassportExpiry,
      },
    );

    if (response2.statusCode == 200) {
      final responseData = json.decode(response2.body);
      print(responseData);
      print(applicantID);
      print("application ID");

      // Show a success dialog with the message from the response
  _showSuccessDialog(responseData['message2'],applicantID);
    } else {
      final responseData = json.decode(response2.body);
      if (response2.body.contains('Integrity constraint violation')) {
        // Show a specific message for duplicate entry
        _showErrorDialog(context, 'Duplicate data found. Please use a different email.');
         setState(() {
      _isLoading = false;
    });
        
      } else {
        // General error message
        _errorMessage = responseData['message2'] ?? 'Registration failed';
        _showErrorDialog(context, _errorMessage);
      }
    }
  } catch (error) {
    print('Error during registration: $error');
    setState(() {
      _errorMessage = 'Error during registration: $error';
    });
  }
    finally {
    setState(() {
      _isLoading = false;
    });
  }
}
void _showSuccessDialog(String message, String applicationID) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              // Navigate to CreateJobseekerEducation screen
              Navigator.pushNamed(
                context,
                AppRouteName.CreateJobseekerEducation,
                arguments: applicationID, // Replace 'your_application_id_here' with the actual application ID
              );
            },
          ),
        ],
      );
    },
  );
}

void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              
                           Navigator.pushReplacementNamed(context, AppRouteName.registerPage);
               
            },
          ),
        ],
      );
    },
  );
}

@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    fillFormWithRandomValues();
  });
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



  @override
Widget build(BuildContext context) {
  _applicantIdController.text = applicantID;

  return Scaffold(
    appBar: AppBar(
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRouteName.mainScreen);
            },
          ),
          const SizedBox(width: 8), // Add some space between the back button and the title
          const Text('Job Seeker Registration'),
        ],
      ),
      backgroundColor: Colors.blueAccent,
    ),
    body: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildTextFormField(
                      controller: _applicantIdController, labelText: 'Candidate ID'),
                  _buildTextFormField(
                      controller: _applicantNameController, labelText: 'Applicant Name'),
                  _buildTextFormField(
                      controller: _fatherSpouseNameController,
                      labelText: 'Father/Spouse Name'),
                  _buildDateField(
                    context: context,
                    label: 'Date of Birth',
                    selectedDate: _selectedDOB?.toString(),
                    onTap: () => _selectDateOfBirth(context)),
                  _buildDropdownField(buildMaritalStatusDropdown()),
                  _buildDropdownField(buildGenderDropdown()),
                  _buildTextFormField(
                      controller: _contactNumberController, labelText: 'Contact Number'),
                  _buildTextFormField(
                      controller: _whatsappController, labelText: 'WhatsApp'),
                  _buildTextFormField(
                      controller: _emailController, labelText: 'Email'),
                  _buildTextFormField(
                      controller: _heightController, labelText: 'Height'),
                  _buildTextFormField(
                      controller: _weightController, labelText: 'Weight'),
                  _buildTextFormField(
                      controller: _addressLine1Controller, labelText: 'Address Line 1'),
                  _buildTextFormField(
                      controller: _addressLine2Controller, labelText: 'Address Line 2'),
                  _buildTextFormField(
                      controller: _pincodeController, labelText: 'Pincode'),
                  _buildTextFormField(
                      controller: _districtController, labelText: 'District'),
                  _buildTextFormField(
                      controller: _stateController, labelText: 'State'),
                  _buildTextFormField(
                      controller: _countryController, labelText: 'Country'),
                  _buildTextFormField(
                      controller: _passportNoController, labelText: 'Passport Number'),
                  _buildDateField(
                      context: context,
                      label: 'Passport Expiry Date',
                      selectedDate:
                          _passportExpiryDateController.text.isNotEmpty
                              ? _passportExpiryDateController.text
                              : null,
                      onTap: () => _selectPassportExpiryDate(context)),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Add My Details',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form != null && form.validate()) {
                        if (_selectedGender == null || _selectedGender!.isEmpty) {
                          _showErrorDialog(context, 'Please select a gender.');
                        } else {
                          _register();
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 8.0),
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    ),
  );
}

Widget _buildTextFormField(
    {required TextEditingController controller, required String labelText}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    ),
  );
}

Widget _buildDateField(
    {required BuildContext context,
    required String label,
    String? selectedDate,
    required Function() onTap}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          filled: true,
          fillColor: Colors.grey[200],
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          selectedDate ?? 'Select $label',
          style: TextStyle(fontSize: 16.0, color: selectedDate != null ? Colors.black : Colors.grey),
        ),
      ),
    ),
  );
}

Widget _buildDropdownField(Widget dropdown) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey),
      ),
      child: dropdown,
    ),
  );
}





void fillFormWithRandomValues() {
  // Generate random name
  final randomName = _generateRandomName();

  // Set fixed values
  const phoneNumber = "7506842855";
  const height = "5.7";
  const weight = 82;

  // Set values in the TextEditingControllers (remove applicant ID)
  //_applicantIdController.text = _generateRandomString(10); // Removed
  _applicantNameController.text = randomName;
  _fatherSpouseNameController.text = _generateRandomName();
  // ... set values for other controllers

  // Simulate selecting a random date (replace with your date picker logic)
  _selectedDOB = DateTime(
      2000 + math.Random().nextInt(21), // Year between 2000 and 2021
      1 + math.Random().nextInt(12), // Month between 1 and 12
      1 + math.Random().nextInt(28)); // Day between 1 and 28 (adjust for leap years)

  // Set pre-defined values for marital status and gender

  _contactNumberController.text = phoneNumber;
  _whatsappController.text = phoneNumber; // Same as contact number
  _emailController.text = "${randomName.toLowerCase()}@gmail.com";
  _heightController.text = height; // Fixed height
  _weightController.text = weight.toString(); // Fixed weight
  _addressLine1Controller.text = _generateRandomAddress();
  _addressLine2Controller.text = _generateRandomAddress(); // Optional address line
  _pincodeController.text = "734101"; // Pincode starting with 1100 (adjust as needed)
  _districtController.text = _generateRandomName();
  _stateController.text = _generateRandomName();
  _countryController.text = _generateRandomCountry();
  _passportNoController.text = _generateRandomString(8); // Random passport number (8 characters)

  // Set fixed passport expiry date (replace with your logic if needed)
  _passportExpiryDateController.text = DateTime(2035, 10, 25).toString();

  // Call setState() to update the UI with the new values
  setState(() {});
}

// Helper functions for generating random data

String _generateRandomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyzAB';
  final random = math.Random();
  return String.fromCharCodes(List.generate(length, (index) => chars.codeUnitAt(random.nextInt(chars.length))));
}

String _generateRandomName() {
  // Replace this with your logic to generate random names (e.g., using a name list or random syllables)
  // You can use external libraries like https://pub.dev/packages/random_name_generator for more advanced name generation
  return "dhiraj26"; // Placeholder for now
}

String _generateRandomAddress() {
  // Replace this with your logic to generate random addresses (e.g., using street names and numbers)
  // You can use external libraries like https://pub.dev/packages/faker for more realistic address generation
  return "123 Main Street"; // Placeholder for now
}

String _generateRandomCountry() {
  // Replace this with your logic to generate random countries (e.g., using a country list)
  // You can use external libraries like https://pub.dev/packages/country_codes for random country selection with codes
  return "India"; // Placeholder for now
}
}