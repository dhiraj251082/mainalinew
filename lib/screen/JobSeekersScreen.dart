import 'package:flutter/material.dart';
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/model/CompleteJobSeekerModel.dart'; // Import the updated model
import 'package:mainalihr/utility/JobSeekerController.dart';
import 'package:mainalihr/utility/search_service.dart';
import 'package:provider/provider.dart';

class GetAllJobSeekersView extends StatefulWidget {
  const GetAllJobSeekersView({super.key});

  @override
  _GetAllJobSeekersViewState createState() => _GetAllJobSeekersViewState();
}

class _GetAllJobSeekersViewState extends State<GetAllJobSeekersView> {
  final JobSeekerController jobSeekerController = JobSeekerController();

  late Future<List<CompleteJobSeekerModel>> jobSeekers; // Update the type to CompleteJobSeekerModel
  List<int> selectedApplicantIds = [];

  @override
  void initState() {
    super.initState();
    jobSeekers = jobSeekerController.fetchJobSeekers();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userCredentials = userProvider.userCredentials;
    final userid = userCredentials?.userId ?? "Guest";
    final username = userCredentials?.username ?? "Guest";
    final clientName = userCredentials?.name ?? "Guest";
    final clientRole = userCredentials?.role ?? "Guest";

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
        child: FutureBuilder<List<CompleteJobSeekerModel>>(
          future: jobSeekers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error: ${snapshot.error}',
                      style: const TextStyle(fontSize: 18, color: Colors.white)));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('No job seekers found.',
                      style: TextStyle(fontSize: 18, color: Colors.white)));
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        CompleteJobSeekerModel jobSeeker = snapshot.data![index];
                        return Card(
                          color: Colors.white70,
                          child: ListTile(
                            title: const Text(
                              'Click on Check Box to select your candidate',
                              style: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                          jobSeeker.fullLengthPhotoUrls.isNotEmpty
                                              ? jobSeeker.fullLengthPhotoUrls[0]
                                              : 'https://via.placeholder.com/150'),
                                    ),
                                    const SizedBox(width: 8),
                                    Checkbox(
                                      value: selectedApplicantIds
                                          .contains(int.parse(jobSeeker.applicantId)),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value != null && value) {
        selectedApplicantIds.add(int.parse(jobSeeker.applicantId)); // Convert to int before adding
      } else {
        selectedApplicantIds.remove(int.parse(jobSeeker.applicantId)); // Convert to int before removing
      }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                    'Name: ${jobSeeker.applicantName}',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                Text(
                                    'Gender: ${jobSeeker.gender}',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                if (jobSeeker.experiences.isNotEmpty)
                                  Text(
                                      'Company Name: ${jobSeeker.experiences[0].companyName} at Department ${jobSeeker.experiences[0].industry}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                if (jobSeeker.educations.isNotEmpty)
                                  Text(
                                      'Education: ${jobSeeker.educations[0].level} at ${jobSeeker.educations[0].instituteName}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
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
                          const SnackBar(
                            content: Text("Please Login to Continue"),
                          ),
                        );
                      } else {
                        print(
                            'Selected Applicant IDs: $selectedApplicantIds and client id is $userid and name is $username');
                        await SearchService.submitSelectedApplicants2(
                                userid, username, clientName, clientRole, selectedApplicantIds)
                            .then((ApiResponse response) {
                          _showMessageDialog(context, response.success, response.message);
                        }).catchError((error) {
                          // Show an error message
                          _showMessageDialog(
                              context, false, 'An error occurred. Please try again later.');
                        });
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void _showMessageDialog(BuildContext context, bool success, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Candidates have been shortlisted successfully. Our team will reach you shortly.'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushNamed(context, AppRouteName.clientNavigation);
              },
            ),
          ],
        );
      },
    );
  }
}
