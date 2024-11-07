import 'package:flutter/material.dart';
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/feature/home/presentation/widget/bottom_navigation.dart';
import 'package:mainalihr/screen/jobstatus/jobapplystatus.dart';
import 'package:mainalihr/utility/search_service.dart';
import 'package:provider/provider.dart';






class ApplicantDetailsScreen extends StatefulWidget {
  const ApplicantDetailsScreen({super.key});

  @override
  _ApplicantDetailsScreenState createState() => _ApplicantDetailsScreenState();
}

class _ApplicantDetailsScreenState extends State<ApplicantDetailsScreen> {
  late Future<ApplicantDetails> _future;
  
 

  @override
  void initState() {
    super.initState();
   
  }
   int _selectedIndex = 0;

 void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Implement navigation logic for each index here
    // For example:
   if (index == 0) {
     Navigator.pushReplacementNamed(context, AppRouteName.loginscreen);
   }
     if (index == 1) {
     Navigator.pushReplacementNamed(context, AppRouteName.mainScreen);
   }
     if (index == 3) {
     Navigator.pushReplacementNamed(context, AppRouteName.ApplicantDetailsScreen);
   }
    // } else if (index == 1) {
    //   Navigator.pushReplacementNamed(context, AppRouteName.CreateJobseekerEducation);
    // } // Add other navigation logic as needed
  }

  @override
  Widget build(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);
  final userCredentials = userProvider.userCredentials;
  final userid = userCredentials?.userId ?? "Guest";
    
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applicant Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<ApplicantDetails>(
             future: SearchService.fetchApplicantDetails(userid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("snaphsot.haserror is ${snapshot.error}");
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final applicantDetails = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Job Seeker: ${applicantDetails.jobSeeker.applicantName}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Job Seeker ID: ${applicantDetails.jobSeeker.applicantId}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: applicantDetails.jobPostings.length,
                    itemBuilder: (context, index) {
                      final jobPosting = applicantDetails.jobPostings[index];
                      return GestureDetector(
                        onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return JobApplyStatus(jobId: jobPosting.jobId.toString(), jobApplies: applicantDetails.jobApplies);
    }));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Job Title: ${jobPosting.jobTitle}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Job ID: ${jobPosting.jobId}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Industry: ${jobPosting.industryName}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Profession: ${jobPosting.professionName}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
      
       bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
          handleNavigation(context, index);
        },
      )

      
    );
  }
}
