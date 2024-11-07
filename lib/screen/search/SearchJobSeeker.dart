import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/feature/home/presentation/widget/bottom_navigation.dart';
import 'package:mainalihr/model/CompleteJobSeekerModel.dart';
import 'package:mainalihr/model/profession_model.dart';
import 'package:mainalihr/screen/sharing/search_data_singleton.dart';
import 'package:mainalihr/utility/ApiUtil.dart';
import 'package:mainalihr/utility/search_service.dart';
import 'package:provider/provider.dart';

class SearchJobSeeker extends StatefulWidget {
  const SearchJobSeeker({super.key});

  @override
  State<SearchJobSeeker> createState() => _SearchJobSeekerState();
}

class _SearchJobSeekerState extends State<SearchJobSeeker> {
  final TextEditingController _filterController = TextEditingController();
  List<Profession> fetchedProfessions = [];
  List<String> selectedProfessions = [];
  List<Profession> professions = [];
  int? minAge;
  int? maxAge;
  String? gender;

  @override
  void initState() {
    super.initState();
    loadProfessions();
  }

  Future<void> loadProfessions() async {
    try {
      ApiUtil apiUtil = ApiUtil();
      fetchedProfessions = await apiUtil.fetchAllProfessions();
      setState(() {
        professions = fetchedProfessions;
      });
    } catch (e) {
      print('Failed to load professions: $e');
    }
  }

  // Filter professions based on user query
  void _filterProfessions(String query) {
    setState(() {
      if (query.isNotEmpty) {
        String lowercaseQuery = query.toLowerCase();
        Set<String> uniqueProfessionNames = {};

        for (var profession in fetchedProfessions) {
          if (profession.professionName.toLowerCase().contains(lowercaseQuery)) {
            uniqueProfessionNames.add(profession.professionName);
          }
        }

        professions = uniqueProfessionNames
            .map((professionName) => fetchedProfessions.firstWhere(
                (profession) => profession.professionName == professionName))
            .toList();
      } else {
        professions = fetchedProfessions;
      }
    });
  }

  // Construct and send search data
  void _searchAndSendData(BuildContext context) async {
    Map<String, dynamic> searchData = {
      'professions': selectedProfessions,
      'gender': gender,
      'minAge': minAge,
      'maxAge': maxAge,
    };

    print("search data $searchData");
    SearchDataSingleton().setSearchData(searchData);

    String jsonData = json.encode(searchData);

    SearchService.sendSearchData(jsonData).then((jobSeekers) {
      print("opening job");

      for (CompleteJobSeekerModel jobSeeker in jobSeekers) {
        print('Applicant ID: ${jobSeeker.applicantId}');
        print('Applicant Name: ${jobSeeker.applicantName}');
        print('Gender: ${jobSeeker.gender}');
        print('Full-Length Photo URLs: ${jobSeeker.fullLengthPhotoUrls}');
        print('Passport Photo URLs: ${jobSeeker.passportPhotoUrls}');
        print('Experiences:');
        for (var experience in jobSeeker.experiences) {
          print('  Company Name: ${experience.companyName}');
          print('  Profession: ${experience.profession}');
          print('  Joining Date: ${experience.joiningDate}');
          print('  Relieving Date: ${experience.relivingDate}');
          print('  Location: ${experience.location}');
        }
        print('Educations:');
        for (var education in jobSeeker.educations) {
          print('  Institute Name: ${education.instituteName}');
          print('  Level: ${education.level}');
        }
      }

      Navigator.pushReplacementNamed(
          context, AppRouteName.GetSelectedView, arguments: jobSeekers);
    }).catchError((error) {
      print('Error retrieving job seekers: $error');
    });
  }

  int _selectedIndex = 0;

  // Handle bottom navigation item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRouteName.loginscreen);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, AppRouteName.mainScreen);
        break;
      case 3:
        Navigator.pushReplacementNamed(
            context, AppRouteName.ApplicantDetailsScreen);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("in search UI");
    final userProvider = Provider.of<UserProvider>(context);
    final userCredentials = userProvider.userCredentials;
    final userid = userCredentials?.userId ?? "Guest";
    final username = userCredentials?.username ?? "Guest";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search JobSeeker'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.search), // Add search icon
            label: const Text('Click Here'), // Add label "Search"
            onPressed: () {
              _searchAndSendData(context); // Call the search function
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black, // Set text color
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: gender,
                hint: const Text('Select Gender'),
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
                items: ['Male', 'Female', 'Both']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter Minimum Age',
                  hintText: 'Enter minimum age',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    minAge = int.tryParse(value);
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter Maximum Age',
                  hintText: 'Enter maximum age',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    maxAge = int.tryParse(value);
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Professions:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _filterController,
                decoration: const InputDecoration(
                  labelText: 'Start Typing Your desired Professions',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  _filterProfessions(value);
                },
              ),
              const SizedBox(height: 10),
              Wrap(
                children: professions.map((profession) {
                  bool isSelected =
                      selectedProfessions.contains(profession.professionName);
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: isSelected,
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              selectedProfessions
                                  .add(profession.professionName);
                            } else {
                              selectedProfessions
                                  .remove(profession.professionName);
                            }
                          });
                        },
                      ),
                      Text(profession.professionName),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
