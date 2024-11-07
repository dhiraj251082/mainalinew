import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/model/Location_currency_model.dart';
import 'package:mainalihr/model/experience_model.dart';
import 'package:mainalihr/model/industry_model.dart';
import 'package:mainalihr/model/profession_model.dart';
import 'package:mainalihr/utility/ApiUtil.dart';
import 'package:provider/provider.dart';



class CreateJobseekerExperience extends StatefulWidget {
  const CreateJobseekerExperience({super.key});

  @override
  _CreateJobseekerExperienceState createState() =>
      _CreateJobseekerExperienceState();
}

class _CreateJobseekerExperienceState
    extends State<CreateJobseekerExperience> {
      

           late TextEditingController  applicantidController;
  late TextEditingController companyNameController;
  late TextEditingController yearOfJoiningController;
  late TextEditingController yearOfLeavingController;
  late TextEditingController jobDescriptionController;
      DateTime? selectedJoiningDate;
DateTime? selectedRelievingDate;



  late String selectedIndustry;
  List<Industry> industries = [];

  late String selectedProfession;
  List<Profession> professions = [];
  late List<Profession> allProfessions;
  List<Profession> filteredProfessions = [];
    late String selectedLocation;
      List<Location> location = [];
       List<Profession> fetchedProfessions = [];
  

 // Assuming you have a way to set the selected industry ID


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  

  String? companyNameError;
  String? yearOfJoiningError;
  String? yearOfLeavingError;
  String? selectedIndustryId;
    String? selectedLocationId;
    List<Experience> experienceDetails = [];
  
  @override
  void initState() {
    super.initState();
    selectedIndustry = '';
    selectedProfession = '';
        selectedLocation = '';
        applicantidController = TextEditingController();
    companyNameController = TextEditingController();
    yearOfJoiningController = TextEditingController();
    yearOfLeavingController = TextEditingController();
    jobDescriptionController = TextEditingController();
  

 
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
      

      // Load professions for the initial industry
      //loadProfessions(selectedIndustry);
    } catch (e) {
      print('Failed to load location: $e');
    }
  }

 void validateAndSubmit() {
    setState(() {
      companyNameError =
          companyNameController.text.isEmpty ? 'Enter Company Name' : null;
      yearOfJoiningError =
          yearOfJoiningController.text.isEmpty
    ? 'Enter Year of Joining' : null;
      yearOfLeavingError = yearOfLeavingController.text.isEmpty
          ? 'Enter Year of Leaving'
          : null;
    });
  }

  bool validateForm() {
    validateAndSubmit();
    return companyNameError == null &&
        yearOfJoiningError == null &&
        yearOfLeavingError == null;
  }

  void addExperience() {
    if (validateForm()) {
      // Create an instance of Experience using the provided constructor
    Experience newExperience = Experience(
  applicantId: applicantidController.text,
  companyName: companyNameController.text,
  industryId: selectedIndustry,
  professionId: selectedProfession,
  locationId:selectedLocation,
  yearOfJoining: selectedJoiningDate != null
      ? DateFormat('yyyy-MM').format(selectedJoiningDate!)
      : '', // Format the date if available, otherwise an empty string
  yearOfLeaving: selectedRelievingDate != null
      ? DateFormat('yyyy-MM').format(selectedRelievingDate!)
      : '', // Format the date if available, otherwise an empty string
  jobDescription: jobDescriptionController.text,
);

      experienceDetails.add(newExperience);
      // Handle the new experience (print for demonstration)


 print('All Experiences:');
    for (Experience experience in experienceDetails) {
      print(experience);
    }

      // Clear input fields after adding an experience entry
      companyNameController.clear();
      yearOfJoiningController.clear();
      yearOfLeavingController.clear();
      jobDescriptionController.clear();
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
  }


Future<void> _selectDate(BuildContext context, DateTime? selectedDate) async {
  final TextEditingController manualDateController = TextEditingController();
  manualDateController.text = selectedDate != null ? DateFormat('MM/yyyy').format(selectedDate) : '';

  final picked = await showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter Date'),
        content: TextFormField(
          controller: manualDateController,
          keyboardType: TextInputType.datetime,
          decoration: const InputDecoration(
            labelText: 'MM/YYYY',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid date (MM/YYYY)';
            }
            return null;
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (manualDateController.text.isNotEmpty) {
                final parsedDate = DateFormat('MM/yyyy').parseLoose(manualDateController.text);
                Navigator.of(context).pop(parsedDate);
                            } else {
                // Date is empty
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a date (MM/YYYY)')));
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );




  if (picked != null && picked != selectedDate) {
    setState(() {
      // Use = for assignment, not ==
      selectedDate == selectedJoiningDate
          ? selectedJoiningDate = picked
          : selectedRelievingDate = picked;

      // Format and set the text controllers
      yearOfJoiningController.text =
          DateFormat('MMM yyyy').format(selectedJoiningDate!);
      yearOfLeavingController.text =
          DateFormat('MMM yyyy').format(selectedRelievingDate!);
    });
  }
}

  String? applicationId;

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  applicationId = ModalRoute.of(context)!.settings.arguments as String?;
  print("the application id $applicationId");
}


  @override
  Widget build(BuildContext context) {

     final userProvider = Provider.of<UserProvider>(context);

  // Retrieve the user credentials from the provider
  final userCredentials = userProvider.userCredentials;

  // Extract the name from the user credentials if available
  final userid = userCredentials?.userId ?? "Guest";
  final username = userCredentials?.username ?? "Guest";
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
  title: const Text('Enter Experience Details'),
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
                controller: companyNameController,
                decoration: const InputDecoration(labelText: 'Company Name'),
              ),
              const SizedBox(height: 8.0),
              if (companyNameError != null)
                Text(
                  companyNameError!,
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
 /* onTap: () {
    print("Industry dropdown tapped");
    // Add any logic you want to execute when the user taps on the Industry dropdown
    onIndustryChange(selectedIndustry);
  },*/
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
           
             // Your TextFormField
const SizedBox(height: 8.0),
TextFormField(
  readOnly: true,
  controller: yearOfJoiningController,
  onTap: () => _selectDate(context, selectedJoiningDate),
  decoration: const InputDecoration(labelText: 'Year of Joining'),
),
const SizedBox(height: 8.0),
if (yearOfJoiningError != null)
  Text(
    yearOfJoiningError!,
    style: const TextStyle(color: Colors.red),
  ),
const SizedBox(height: 8.0),
if (yearOfJoiningError != null)
  Text(
    yearOfJoiningError!,
    style: const TextStyle(color: Colors.red),
  ),
              TextFormField(
                readOnly: false,
  controller: yearOfLeavingController,
  onTap: () => _selectDate(context, selectedRelievingDate),
  decoration: const InputDecoration(labelText: 'Year of Leaving'),
              ),
              const SizedBox(height: 8.0),
              if (yearOfLeavingError != null)
                Text(
                  yearOfLeavingError!,
                  style: const TextStyle(color: Colors.red),
                ),
              TextFormField(
                controller: jobDescriptionController,
                decoration: const InputDecoration(labelText: 'Job Description'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addExperience();
                  }
                },
                child: const Text('Add Experience'),
              ),
               ElevatedButton(
           onPressed: () {
    if (_formKey.currentState!.validate()) {
     addExperience(); // Add the current education to the list
      ApiUtil.submitAllExperience(experienceDetails).then((ApiResponse response) {
    print("i am here");
    _showMessageDialog(context,response.success, response.message,applicationId.toString()); // Corrected variable name
  }).catchError((error) {
    // Show an error message
    _showMessageDialog(context,false,'An error occurred. Please try again later.','No data');
  }); // Submit all education records
                }
        },
  child: const Text('Submit Experience'),
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
    AppRouteName.UploadDocumentView,
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