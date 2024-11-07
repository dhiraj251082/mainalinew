import 'package:flutter/material.dart';
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/model/education_model.dart';
import 'package:mainalihr/utility/ApiUtil.dart';
import 'package:provider/provider.dart';

class CreateJobseekerEducation extends StatefulWidget {
  const CreateJobseekerEducation({super.key});



  

  @override
  _CreateJobseekerEducationState createState() =>
      _CreateJobseekerEducationState();
}

class _CreateJobseekerEducationState extends State<CreateJobseekerEducation> {

  late TextEditingController applicantidController;
  late TextEditingController instituteNameController;
  late TextEditingController yearOfPassingController;
  late TextEditingController specialityController;
  late TextEditingController gradePercentageController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  late String selectedLevel;
  List<String> educationLevels = [
    'Select Education Level',
    'Below Class 10',
    '10 Pass',
    '10+2',
    'Diploma',    
    'Graduate',
    'Post Graduate',
  ];

  String? instituteNameError;
  String? selectedLevelError;
  String? yearOfPassingError;

  List<Education> educationDetails = [];

  @override
  void initState() {
    super.initState();
    applicantidController = TextEditingController();
    instituteNameController = TextEditingController();
    yearOfPassingController = TextEditingController();
    specialityController = TextEditingController();
    gradePercentageController = TextEditingController();
    selectedLevel = educationLevels[0];

  }

  String? applicationId;

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  applicationId = ModalRoute.of(context)!.settings.arguments as String?;
  print("the application id $applicationId");
}

  @override
  void dispose() {
    applicantidController.dispose();

    instituteNameController.dispose();
    yearOfPassingController.dispose();
    specialityController.dispose();
    gradePercentageController.dispose();
    super.dispose();
  }

  void validateAndSubmit() {
    setState(() {
      instituteNameError =
          instituteNameController.text.isEmpty ? 'Enter Institute Name' : null;
      selectedLevelError = selectedLevel == educationLevels[0]
          ? 'Select Level of Education'
          : null;
      yearOfPassingError = yearOfPassingController.text.isEmpty
          ? 'Enter Year of Passing'
          : null;
    });
  }

  bool validateForm() {
    validateAndSubmit();
    return instituteNameError == null &&
        selectedLevelError == null &&
        yearOfPassingError == null;
  }

void addEducation() {
  if (validateForm()) {
    Education newEducation = Education(
      applicantId: applicantidController.text,
      instituteName: instituteNameController.text,
      level: selectedLevel,
      yearOfPassing: yearOfPassingController.text,
      documentLocation: '',
      specialization: specialityController.text,
      gradePercentage: gradePercentageController.text,
    );
    educationDetails.add(newEducation);
    // Clear input fields after adding an education entry
    instituteNameController.clear();
    yearOfPassingController.clear();
    specialityController.clear();
    gradePercentageController.clear();
    selectedLevel = educationLevels[0]; // Reset dropdown to default
    setState(() {}); // Update the UI
  } else {
    // Show a SnackBar with an error message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error: Please fill in all required fields.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}  @override
  Widget build(BuildContext context) {
    
    final userProvider = Provider.of<UserProvider>(context);

  // Retrieve the user credentials from the provider
  final userCredentials = userProvider.userCredentials;

  // Extract the name from the user credentials if available
  final userid = userCredentials?.userId ?? "Guest";
  final username = userCredentials?.username ?? "Guest";
  print("userid in Education $userid");
 if(username!="Guest")
 {
     applicantidController.text=userid;
 }
 else
 {
  applicantidController.text=applicationId.toString();
 }


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This disables the automatic back button
  title: const Text('Enter Your Highest Eduction'),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pushReplacementNamed(context, AppRouteName.jobSeekerNavigation);
    },
  ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: applicantidController,
                decoration: const InputDecoration(labelText: 'Applicant ID'),
              ),
              TextFormField(
                controller: instituteNameController,
                decoration: const InputDecoration(labelText: 'Institute Name'),
              ),
              const SizedBox(height: 8.0),
              if (instituteNameError != null)
                Text(
                  instituteNameError!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedLevel,
                items: educationLevels.map((String level) {
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLevel = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Level of Education',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              if (selectedLevelError != null)
                Text(
                  selectedLevelError!,
                  style: const TextStyle(color: Colors.red),
                ),
              TextFormField(
                controller: yearOfPassingController,
                decoration: const InputDecoration(labelText: 'Year of Passing'),
              ),
              const SizedBox(height: 8.0),
              if (yearOfPassingError != null)
                Text(
                  yearOfPassingError!,
                  style: const TextStyle(color: Colors.red),
                ),
              TextFormField(
                controller: specialityController,
                decoration: const InputDecoration(labelText: 'Speciality/Honours'),
              ),
              TextFormField(
                controller: gradePercentageController,
                decoration: const InputDecoration(labelText: 'Grade/Percentage'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addEducation();
                  }
                },
                child: const Text('Add Education'),
              ),
             ElevatedButton(
           onPressed: () {
    if (_formKey.currentState!.validate()) {
      addEducation(); // Add the current education to the list
      ApiUtil.submitAllEducation(educationDetails).then((ApiResponse response) {
    print("i am here");
    _showMessageDialog(context,response.success, response.message,applicationId.toString()); // Corrected variable name
  }).catchError((error) {
    // Show an error message
    _showMessageDialog(context,false,'An error occurred. Please try again later.','No data');
  }); // Submit all education records
                }
        },
  child: const Text('Submit Education'),
         ),
            ],
          ),
        ),
      ),
    );
  }
  void _showMessageDialog(BuildContext context,bool success, String message,String applicationID) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Registration Status'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {

  if (true) {
  Navigator.pushNamed(
    context,
    AppRouteName.CreateJobseekerExperience,
    arguments: applicationID, // Replace 'your_application_id_here' with the actual application ID
  );
}

            },
          ),
        ],
      );
    },
  );
}
}
