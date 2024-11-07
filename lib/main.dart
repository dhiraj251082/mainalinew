import 'package:flutter/material.dart';
import 'package:mainalihr/client_screen/client_registration.dart';
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/core/theme/app_theme.dart';
import 'package:mainalihr/feature/get_started/presentation/get_started_screen.dart';
import 'package:mainalihr/feature/home/presentation/home_screen.dart';
import 'package:mainalihr/feature/home/presentation/home_screen2.dart';
import 'package:mainalihr/screen/ClientEnquiry.dart';
import 'package:mainalihr/screen/Education.dart';
import 'package:mainalihr/screen/Experience.dart';
import 'package:mainalihr/screen/JobSeekersScreen.dart';
import 'package:mainalihr/screen/Jobposting.dart';
import 'package:mainalihr/screen/Jobseeker.dart';
import 'package:mainalihr/screen/UploadDocumentView.dart';
import 'package:mainalihr/screen/clientNavigation.dart';
import 'package:mainalihr/screen/home/client/demandidstatus.dart';
import 'package:mainalihr/screen/jobstatus/jobseekerjobstatus.dart';
import 'package:mainalihr/screen/loginscreen.dart';
import 'package:mainalihr/screen/register_page.dart';
import 'package:mainalihr/screen/search/GetSelectedView.dart';
import 'package:mainalihr/screen/search/SearchJobSeeker.dart';
import 'package:mainalihr/screen/search/getPassport.dart';
import 'package:mainalihr/ui/profileui.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';



void main() {
  runApp(
    ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  static const String baseUrl = "http://24.144.80.8";
  const MyApp({super.key});
  // Define a static method to generate the dynamic endpointR
  static String generateEndpoint(String endpoint) {
    return "$baseUrl/$endpoint";
  
  }
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Main Screen",
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      initialRoute: AppRouteName.mainScreen,
      routes: {
        AppRouteName.getStarted: (context) => const GetStartedScreen(),
        AppRouteName.home: (context) => const HomeScreen(),
        AppRouteName.mainScreen: (context) => const MainScreen(),
                AppRouteName.jobSeekerNavigation: (context) => const JobSeekerNavigation(),
                 AppRouteName.registerPage: (context) => const RegisterPage(),
                  AppRouteName.CreateJobseekerExperience: (context) => const CreateJobseekerExperience(),
               AppRouteName.CreateJobseekerEducation: (context) => const CreateJobseekerEducation(),

                AppRouteName.UploadDocumentView: (context) => const UploadDocumentView(),
                AppRouteName.CreateJobseekerJobposting: (context) => const CreateJobseekerJobposting(),
               AppRouteName.GetAllJobSeekersView: (context) => const GetAllJobSeekersView(),
               AppRouteName.clientNavigation: (context) => const ClientNavigation(),
                        AppRouteName.HomeScreen2: (context) => const HomeScreen2(),
                        AppRouteName.loginscreen: (context) => loginscreen(),
                             AppRouteName.SearchJobSeeker: (context) => const SearchJobSeeker(),
                               AppRouteName.GetSelectedView: (context) => const GetSelectedView(),
                                 AppRouteName.SelectedApplicantsScreen: (context) => const SelectedApplicantsScreen(),
                                  AppRouteName.ApplicantDetailsScreen: (context) => const ApplicantDetailsScreen(),
                                            AppRouteName.ClientDetailsScreen: (context) => const ClientDetailsScreen(),
                                                         AppRouteName.ProfileUI: (context) => const ProfileUI(),                                                                   
                                                      
                                                        AppRouteName.RecordView : (context) => const RecordView(),                     
                  
                                 
                               
                             

      },
      onGenerateRoute: AppRoute.generate,

    );
  }
}
class AppColor {
 static Color shade50 = const Color(0xFFacdde2);
  static Color shade100 = const Color(0xFF9bd6dc);
  static Color shade200 = const Color(0xFF8acfd6);
}
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

   Future<void> _launchFacebookUrl() async {
    final Uri facebookUrl = Uri.parse('https://facebook.com/mainalihr/');
    if (await canLaunchUrl(facebookUrl)) {
      await launchUrl(facebookUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $facebookUrl';
    }
  }

    Future<void> _launchMainalihrUrl() async {
    final Uri facebookUrl = Uri.parse('https://mainalihr.com/');
    if (await canLaunchUrl(facebookUrl)) {
      await launchUrl(facebookUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $facebookUrl';
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: const Text(
          'Welcome',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColor.shade50,
                AppColor.shade100,
                AppColor.shade200,
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10), // Increased spacing for the logo
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/logo.jpg'),
                ),
              ),
              
                                    const SizedBox(height: 10),
                          const Text(
                            'Approved By Ministry Of External Affairs\nGovernment of India',
  textAlign: TextAlign.center,
  style: TextStyle(color: Color.fromARGB(255, 8, 8, 135), fontSize: 16),
                          ),
                          const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  ElevatedButton.icon(
                                    onPressed: () => _hireCandidate(context), // Assuming _hireCandidate is a function to handle hiring
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue.shade800,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                    ),
                                    icon: const Icon(
                                      Icons.handshake, // Icon for hiring
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    label: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                      child: Text(
                                        'Hire Candidate', // Text for hiring button
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20), // Added spacing between buttons
                                  ElevatedButton.icon(
                                    onPressed: () => _findJob(context), // Assuming _findJob is a function to handle finding job
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue.shade800,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                    ),
                                    icon: const Icon(
                                      Icons.search, // Icon for finding job
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    label: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                      child: Text(
                                        'Find Job', // Text for finding job button
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                 _launchFacebookUrl();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                ),
                                icon: const Icon(Icons.facebook),
                                label: Text(
                                  'Facebook',
                                  style: TextStyle(color: Colors.blue.shade800, fontSize: 15),
                                ),
                              ),
                             ElevatedButton.icon(
          onPressed: () {
            _launchFacebookUrl();
           
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          icon: const Icon(
            FontAwesomeIcons.youtube,
            color: Colors.red, // YouTube's red color
          ),
          label: Text(
            'YouTube',
            style: TextStyle(color: Colors.blue.shade800, fontSize: 15),
          ),
        ),
                            ],
                          ),
                          const SizedBox(height: 10),
                         
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Facebook button functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 243, 244, 246),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                ),
                                icon: const Icon(Icons.dataset_linked_outlined),
                                label: Text(
                                  'Linkdin',
                                  style: TextStyle(color: Colors.blue.shade800, fontSize: 15),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Instagram button functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 239, 235, 236),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                ),
                                icon: const Icon(Icons.camera_enhance_sharp),
                                label: Text(
                                  'Instagram',
                                  style: TextStyle(color: Colors.blue.shade800, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                             const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  _launchMainalihrUrl();
                                  // Facebook button functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 243, 244, 246),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                ),
                                icon: const Icon(Icons.web_sharp),
                                label: Text(
                                  'Our Webpage',
                                  style: TextStyle(color: Colors.blue.shade800, fontSize: 15),
                                ),
                              ),
                             
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle hiring
  void _hireCandidate(BuildContext context) {
     Navigator.pushReplacementNamed(context, AppRouteName.clientNavigation);
   
  }

  // Function to handle finding job
  void _findJob(BuildContext context) {
     Navigator.pushReplacementNamed(context, AppRouteName.jobSeekerNavigation);
    // Implement finding job functionality
  }
}
