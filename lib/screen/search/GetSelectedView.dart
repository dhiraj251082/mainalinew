import 'package:flutter/material.dart';
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/model/CompleteJobSeekerModel.dart'; // Use the new model
import 'package:mainalihr/screen/sharing/search_data_singleton.dart';
import 'package:mainalihr/utility/search_service.dart';
import 'package:provider/provider.dart';

class GetSelectedView extends StatefulWidget {
  const GetSelectedView({super.key});

  @override
  _GetSelectedViewState createState() => _GetSelectedViewState();
}

class _GetSelectedViewState extends State<GetSelectedView> {
  List<int> selectedApplicantIds = [];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userCredentials = userProvider.userCredentials;
    final userid = userCredentials?.userId ?? "Guest";
    final username = userCredentials?.username ?? "Guest";
    final clientName = userCredentials?.name ?? "Guest";
    final clientRole = userCredentials?.role ?? "Guest";

    // Access search data
    Map<String, dynamic> searchData = SearchDataSingleton().getSearchData();
    List<String>? selectedProfessions = searchData['professions'];
    int? minAge = searchData['minAge'];
    int? maxAge = searchData['maxAge'];

    // Retrieve the job seekers passed as arguments
    final List<CompleteJobSeekerModel> jobSeekers = ModalRoute.of(context)?.settings.arguments as List<CompleteJobSeekerModel>;

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
            const SizedBox(width: 8),
            const Text('Current Hiring'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 234, 237, 239),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.red],
          ),
        ),
        child: jobSeekers.isEmpty
            ? const Center(child: Text('No job seekers found.', style: TextStyle(fontSize: 18, color: Colors.white)))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: jobSeekers.length,
                      itemBuilder: (context, index) {
                        CompleteJobSeekerModel jobSeeker = jobSeekers[index];
                        return Card(
                          color: Colors.white70,
                          child: ListTile(
                            title: const Text('Click on Check Box to select your candidate', style: TextStyle(color: Colors.black, fontSize: 20)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Image.network(jobSeeker.passportPhotoUrls.isNotEmpty ? jobSeeker.passportPhotoUrls[0] : 'https://via.placeholder.com/150'),
                                    ),
                                    const SizedBox(width: 8),
                                    Checkbox(
                                      value: selectedApplicantIds.contains(int.parse(jobSeeker.applicantId)),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value != null && value) {
                                            selectedApplicantIds.add(int.parse(jobSeeker.applicantId));
                                          } else {
                                            selectedApplicantIds.remove(int.parse(jobSeeker.applicantId));
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Text('Name: ${jobSeeker.applicantName}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                Text('Gender: ${jobSeeker.gender}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                if (jobSeeker.experiences.isNotEmpty) ...[
                                  Text('Company Name: ${jobSeeker.experiences[0].companyName}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                  Text('Industry: ${jobSeeker.experiences[0].industry}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                  Text('Profession: ${jobSeeker.experiences[0].profession}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                ],
                                const SizedBox(height: 8),
                                if (jobSeeker.educations.isNotEmpty) ...[
                                  Text('Education: ${jobSeeker.educations[0].level} at ${jobSeeker.educations[0].instituteName}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                ],
                                const SizedBox(height: 8),
                                Text('Total Experience: ${jobSeeker.experiences.length} years', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                // Add more details as needed
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (userid == "Guest") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Please Login to Continue.'),
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, AppRouteName.loginscreen);
                              },
                            ),
                          ),
                        );
                      } else {
                        print('Selected Applicant IDs: $selectedApplicantIds and client id is $userid and name is $username');
                        await SearchService.submitSelectedApplicants(userid, username, clientName, clientRole, selectedApplicantIds, searchData)
                            .then((ApiResponse response) {
                          _showMessageDialog(context, response.success, response.message);
                        }).catchError((error) {
                          _showMessageDialog(context, false, 'An error occurred. Please try again later.');
                        });
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
      ),
    );
  }

  void _showMessageDialog(BuildContext context, bool success, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your Demand'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                if (success) {
                  Navigator.pushNamed(context, AppRouteName.clientNavigation);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
