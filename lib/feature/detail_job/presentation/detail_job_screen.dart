import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/core/theme/app_color.dart';
import 'package:mainalihr/model/JobPostingModel.dart';
import 'package:mainalihr/utility/job_postings_controller.dart';
import 'package:provider/provider.dart';

enum _Tab {
  requirement,
  about,  
}

class DetailJobScreen extends StatelessWidget {
DetailJobScreen({super.key});
    JobPostingsController jobPostingsController = JobPostingsController();
    Future<void> sendApplication(String applicationId, String? jobId) async {
  // Check if jobId is null
  if (jobId == null) {
    print('Error: jobId is null');
    return; // or handle the error in any other appropriate way
  }

  // Now jobId is non-null, proceed with your logic
  // Rest of your sendApplication method...
}  
@override
Widget build(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);

  // Retrieve the user credentials from the provider
  final userCredentials = userProvider.userCredentials;

  // Extract the name from the user credentials if available
  final userid = userCredentials?.userId ?? "Guest";
  final username = userCredentials?.username ?? "Guest";
  final job = ModalRoute.of(context)?.settings.arguments as JobPostingModel?;
  final selectedTab = ValueNotifier<_Tab>(_Tab.requirement);
  String? jobIdNew;
  String? jobDiscription;
  String? catagory;
  if (job != null) {
    jobIdNew = job.jobId.toString();
    jobDiscription = job.jobDescription.toString();
    catagory = job.professionName;
  }

  // Print the userId

  return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        splashRadius: 24,
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      title: Text(
        "Hi, $username", // Display the user's ID in the app bar
        style: const TextStyle(fontSize: 20),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          splashRadius: 24,
          icon: const Icon(
            Icons.bookmark_border_rounded,
            color: Colors.black,
          ),
        ),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                if (job != null) ...[
                  Text(
                    job.jobTitle ?? '',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    job.companyName ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ValueListenableBuilder<_Tab>(
                    valueListenable: selectedTab,
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  selectedTab.value = _Tab.requirement;
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: value == _Tab.requirement ? AppColor.primaryColor : Colors.grey,
                                ),
                                child: const Text("Requirement"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  selectedTab.value = _Tab.about;
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: value == _Tab.about ? AppColor.primaryColor : Colors.grey,
                                ),
                                child: const Text("About"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Display the job details based on the selected tab...
                          if (value == _Tab.requirement)
                            Text(
                              jobDiscription ?? '',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.justify,
                            ),
                          if (value == _Tab.about)
                            Text(
                              'Other information about the job.',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.justify,
                            ),
                        ],
                      );
                    },
                  ),
                ] else
                  const SizedBox(),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () async {
                if (userid == "Guest") {
                  // If the user is a guest, show a message and return
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
                  return;
                }

                // Check if jobIdNew is not null before calling sendApplication
                if (jobIdNew != null) {
                  await jobPostingsController.sendApplication(userid, jobIdNew).then((ApiResponse response) {
  
    _showMessageDialog(context,response.success, response.message); // Corrected variable name
  }).catchError((error) {
    // Show an error message
    _showMessageDialog(context,false,'An error occurred. Please try again later.');
  }); // Submit all education records// Submit all education records;
                } else {
                  print('Error: jobIdNew is null');
                  // Handle the error in any appropriate way
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ), backgroundColor: AppColor.primaryColor,
              ),
              child: const Text(
                "Apply Now",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    ),
    
  );
}


  void _showMessageDialog(BuildContext context,bool success, String message) {
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
    AppRouteName.jobSeekerNavigation,
    // Replace 'your_application_id_here' with the actual application ID
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