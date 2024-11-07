import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/model/JobPostingModel.dart';
import 'package:mainalihr/model/Location_currency_model.dart';
import 'package:mainalihr/model/industry_model.dart';
import 'package:mainalihr/model/profession_model.dart';
import 'package:mainalihr/utility/ApiUtil.dart';

class CreateJobseekerJobposting extends StatefulWidget {
  const CreateJobseekerJobposting({super.key});

  @override
  _CreateJobseekerJobpostingState createState() =>
      _CreateJobseekerJobpostingState();
}

class _CreateJobseekerJobpostingState
    extends State<CreateJobseekerJobposting> {


   late TextEditingController jobIdController;
  late TextEditingController companyNameController;
  late TextEditingController jobTitleController;
  late TextEditingController jobDescriptionController;
  late TextEditingController salaryController;
 

  late TextEditingController minAgeController;
  late TextEditingController maxAgeController;
  late TextEditingController applicationIdController;
  late bool accommodation = false;
  late bool food = false;
  late bool transport = false;

  DateTime? selectedInterviewDate;

  late String selectedIndustry;
  List<Industry> industries = [];
  late String selectedProfession;
  List<Profession> professions = [];
  late List<Profession> allProfessions = [];
  List<Profession> filteredProfessions = [];
  late String selectedLocation;
  List<Location> location = [];
 List<Profession> fetchedProfessions = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String selectedminimumqualification;
  List<String> jobpostingminimumqualification= [
    'Select Education Level',
    'Below Class 10',
    '10 Pass',
    '10+2',
    'Diploma',    
    'Graduate',
    'Post Graduate',
  ];
    late String selectedgender;
  List<String> jobpostinggender = [
    'Select Gender',
    'male',
    'female',
    'both',
    
  ];

  int? jobIdError;
  String? companyNameError;
  String? jobTitleError;
  String? jobDescriptionError;
  String? salaryError;
  String? minimumQualificationError;
  String? genderError;
  String? minAgeError;
  String? maxAgeError;
  String? applicationIdError;
    String? accomodationError;
      String? fooddError;
        String? interviewdateError;
          String? transportError;
  String? selectedIndustryId;
  String? applicationId;
  
  Future<void> _selectInterviewDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedInterviewDate) {
      setState(() {
        selectedInterviewDate =picked;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    selectedIndustry = '';
selectedProfession = '';
selectedLocation = '';
jobIdController = TextEditingController();
companyNameController = TextEditingController();
jobTitleController = TextEditingController();
jobDescriptionController = TextEditingController();
salaryController = TextEditingController();
  selectedminimumqualification = jobpostingminimumqualification[0];
selectedgender=jobpostinggender[0];
minAgeController = TextEditingController();
maxAgeController = TextEditingController();
accommodation = false;
food = false;
transport = false;

applicationIdController = TextEditingController();

   loadIndustries();
     loadProfessions();
           loadLocations();

   // Load industries when the widget is initialized


  }

  Future<void> loadIndustries() async {
    try {
             // print("this is industry" + selectedIndustry);
      ApiUtil apiUtil = ApiUtil(); // Create an instance of the class
List<Industry> fetchedIndustries= await apiUtil.fetchIndustries();
    
      setState(() {
        industries = fetchedIndustries;
             selectedIndustry = industries.isNotEmpty ? industries[0].id.toString() : '';
        //selectedIndustry = 'Select Industry';
              });
      

      // Load professions for the initial industry
      //loadProfessions(selectedIndustry);
    } catch (e) {
      print('Failed to load industries: $e');
    }
  }
    Future<void> loadProfessions() async {
       //List<Profession> fetchedProfessions = [];
        ApiUtil apiUtil = ApiUtil(); 
        fetchedProfessions =await apiUtil.fetchAllProfessions();
    try {
        ApiUtil apiUtil = ApiUtil(); 
          fetchedProfessions =await apiUtil.fetchAllProfessions();
             //   print("Professions in select all: $fetchedProfessions");

      setState(() {

        professions = fetchedProfessions;


          selectedProfession = professions.isNotEmpty
            ? professions[0].id.toString()
            : '';
               //  print("Filtered Professions in select all: $fetchedProfessions");
    });    
         } catch (e) {
      print('Failed to load professions: $e');  
    }
        //Rprint("Professions after  in select all: $fetchedProfessions");
  }

void filterProfessionsByIndustry() {
//  print("Filtered Professions in select all: $fetchedProfessions");


  //print("filter called");
  print("the selected Industry is: '$selectedIndustryId'");
  
  try {
    int? parsedIndustryId = int.tryParse(selectedIndustryId ?? "");
    print("the parsed industry  $parsedIndustryId");
    if (parsedIndustryId != null) {
      // Proceed with filtering using fetchedProfessions

  professions = fetchedProfessions
    .where((profession) {
      return profession.industryId == parsedIndustryId;
    })
    .toList(); 

      selectedProfession = professions.isNotEmpty
          ? professions[0].id.toString()
          : '';
      print("Filtered Professions: $professions");
    } else {
      // Handle the case where selectedIndustryId is not a valid integer
      print("Invalid selectedIndustryId: $selectedIndustryId");
    }
  } catch (e) {
    // Handle any errors that occur during filtering
    print("Error filtering professions: $e");
  }
}




void onIndustryChange(String newIndustryId) {
 // print("calling filter");
  setState(() {
    selectedIndustryId = newIndustryId;
  });

  filterProfessionsByIndustry(); // Call the function to filter professions

  setState(() {
    // Update UI with the filtered professions
    selectedProfession = professions.isNotEmpty
        ? professions[0].id.toString()
        : '';
    // Ensure selectedProfession is set
  });
}


 




  Future<void> loadLocations() async {
    try {
              print("this is Location$selectedLocation");
      ApiUtil apiUtil = ApiUtil(); // Create an instance of the class
List<Location> fetchedLocations= await apiUtil.fetchLocations();
    
      setState(() {
        location = fetchedLocations;
        selectedLocation = location.isNotEmpty ? location[0].id.toString() : '';
        print("this is Location$selectedLocation");
      });
          } catch (e) {
      print('Failed to load location: $e');
    }
  }

  List<JobPostingModel> jobpostingRecords = [];

  bool validateForm() {
    bool isValid = true;

    if (companyNameController.text.isEmpty) {
      setState(() {
        companyNameError = 'Enter Company Name';
      });
      isValid = false;

    }

    if (jobTitleController.text.isEmpty) {
      setState(() {
        jobTitleError = 'Enter Job Title';
      });
      isValid = false;
   
    }

    if (jobDescriptionController.text.isEmpty) {
      setState(() {
        jobDescriptionError = 'Enter Job Description';
      });
      isValid = false;
    }

    if (salaryController.text.isEmpty) {
      setState(() {
        salaryError = 'Enter Salary';
      });
      isValid = false;

    }





    if (minAgeController.text.isEmpty) {
      setState(() {
        minAgeError = 'Enter Minimum Age';
      });
      isValid = false;
      
    }

    if (maxAgeController.text.isEmpty) {
      setState(() {
        maxAgeError = 'Enter Maximum Age';
      });
      isValid = false;
    
    }

   
    
    print(applicationIdError);

    return isValid;
  }

  void validateAndSubmit() {
   
  setState(() {
    if (validateForm()) {

       print('Selected Gender: $selectedgender');
       print('Selected Minimum Qualification: $selectedminimumqualification');
      // If no errors, create a new JobPostingModel instance and add it to the list
      JobPostingModel newJobPosting = JobPostingModel(
      jobId: int.tryParse(jobIdController.text), 
          companyName: companyNameController.text,
          jobTitle: jobTitleController.text,
          industryName: selectedIndustry,
          professionName: selectedProfession,
          jobDescription: jobDescriptionController.text,
          locationName: selectedLocation,
          salary: salaryController.text,
          minimumQualification: selectedminimumqualification,
          gender: selectedgender,
          minAge: minAgeController.text,
          maxAge: maxAgeController.text,
        //  applicationId: applicationIdController.text,
         accomodation: accommodation,
          food: food,
          interviewdate: selectedInterviewDate,
          transport: transport,

      );

      // Add the new job posting to the jobpostingRecords list
      jobpostingRecords.add(newJobPosting);

      // Handle the new job posting (print for demonstration)
      print('All Job Postings:');
      for (JobPostingModel jobPosting in jobpostingRecords) {
        print(jobPosting);
      }

      // Clear input fields after adding a job posting
      companyNameController.clear();
      jobTitleController.clear();
      jobDescriptionController.clear();
      salaryController.clear();


      minAgeController.clear();
      maxAgeController.clear();
      applicationIdController.clear();

      // Update the UI
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: Some Field is missing Please scroll up .'),
          backgroundColor: Colors.red,
        ),
      );
    }
  });
}


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title:  Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                        Navigator.pushReplacementNamed(context, AppRouteName.clientNavigation); // Navigate back when back button is pressed
              },
            ),
            const SizedBox(width: 8), // Add some space between the back button and the title
            const Text('Show All Job Seeker'),
          ],
        ),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: jobIdController,
                decoration: const InputDecoration(labelText: 'Job ID'),
              ),
              TextFormField(
                controller: companyNameController,
                decoration: const InputDecoration(labelText: 'Company Name'),
              ),
              if (companyNameError != null)
                Text(
                  companyNameError!,
                  style: const TextStyle(color: Colors.red),
                ),
              TextFormField(
                controller: jobTitleController,
                decoration: const InputDecoration(labelText: 'Job Title'),
              ),
              if (jobTitleError != null)
                Text(
                  jobTitleError!,
                  style: const TextStyle(color: Colors.red),
                ),
              TextFormField(
                controller: jobDescriptionController,
                decoration: const InputDecoration(labelText: 'Job Description'),
              ),
              if (jobDescriptionError != null)
                Text(
                  jobDescriptionError!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedIndustry,
                items: industries.map((Industry industry) {
                  return DropdownMenuItem<String>(
                    value: industry.id.toString(),
                    child: Text(industry.industryName),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  print("Industry dropdown changed: $newValue");
                  setState(() {
                    selectedIndustry = newValue!;
                    onIndustryChange(selectedIndustry);
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Industry',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              DropdownButtonFormField<String>(
                value: selectedProfession,
                items: professions.map((Profession profession) {
                  return DropdownMenuItem<String>(
                    value: profession.id.toString(),
                    child: Text(profession.professionName),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedProfession = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Profession',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedLocation,
                items: location.map((Location location) {
                  return DropdownMenuItem<String>(
                    value: location.id.toString(),
                    child: Text(location.location_name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLocation = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: salaryController,
                decoration: const InputDecoration(labelText: 'Salary'),
              ),
              if (salaryError != null)
                Text(
                  salaryError!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedminimumqualification,
                items: jobpostingminimumqualification.map((String minimumQualification) {
                  return DropdownMenuItem<String>(
                    value: minimumQualification,
                    child: Text(minimumQualification),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedminimumqualification = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Minimum Qualification Required',
                  border: OutlineInputBorder(),
                ),
              ),
               
          const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedgender,
                items: jobpostinggender.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                   selectedgender = newValue!;
                   
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Select Gender',
                  border: OutlineInputBorder(),
                ),
              ),

              TextFormField(
                controller: minAgeController,
                decoration: const InputDecoration(labelText: 'Minimum Age'),
              ),
              if (minAgeError != null)
                Text(
                  minAgeError!,
                  style: const TextStyle(color: Colors.red),
                ),
                   TextFormField(
                controller: maxAgeController,
                decoration: const InputDecoration(labelText: 'Maximum Age'),
              ),
              if (minAgeError != null)
                Text(
                 maxAgeError!,
                  style: const TextStyle(color: Colors.red),
                ),
              
          Row(
                  children: [
                    Checkbox(
                      value: accommodation,
                      onChanged: (bool? value) {
                        setState(() {
                          accommodation = value ?? false;
                        });
                      },
                    ),
                    const Text('Accommodation'),
                  ],
                ),
                // Food checkbox
                Row(
                  children: [
                    Checkbox(
                      value: food,
                      onChanged: (bool? value) {
                        setState(() {
                          food = value ?? false;
                        });
                      },
                    ),
                    const Text('Food'),
                  ],
                ),
                // Transport checkbox
                Row(
                  children: [
                    Checkbox(
                      value: transport,
                      onChanged: (bool? value) {
                        setState(() {
                          transport = value ?? false;
                        });
                      },
                    ),
                    const Text('Transport'),
                  ],
                ),
                // Interview Date d
             if (selectedInterviewDate != null)
                  Text('Selected Interview Date: ${DateFormat('yyyy-MM-dd').format(selectedInterviewDate!)}'),
                ElevatedButton(
                  onPressed: () => _selectInterviewDate(context),
                  child: const Text('Select Interview Date'),
                ),
             
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    validateAndSubmit();
                    ApiUtil.submitAllJobPosting(jobpostingRecords); 
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}
