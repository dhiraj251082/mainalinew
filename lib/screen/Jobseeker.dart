import 'package:flutter/material.dart';
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/core/theme/app_color.dart';
import 'package:mainalihr/feature/home/presentation/widget/bottom_navigation.dart';
import 'package:provider/provider.dart';

class JobSeekerNavigation extends StatefulWidget {
  const JobSeekerNavigation({super.key});

  @override
  _JobSeekerNavigationState createState() => _JobSeekerNavigationState();
}

class _JobSeekerNavigationState extends State<JobSeekerNavigation> {
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
    if (index == 4) {
     Navigator.pushReplacementNamed(context, AppRouteName.RecordView);
   }
   
    // } else if (index == 1) {
    //   Navigator.pushReplacementNamed(context, AppRouteName.CreateJobseekerEducation);
    // } // Add other navigation logic as needed
  }

  @override
  Widget build(BuildContext context) {

      final userProvider = Provider.of<UserProvider>(context);

  // Retrieve the user credentials from the provider
  final userCredentials = userProvider.userCredentials;

  // Extract the name from the user credentials if available
  final userid = userCredentials?.userId ?? "Guest";
  final username = userCredentials?.username ?? "Guest";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Seeker Screen'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColor.gradientBackground,
        ),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              MyButton(
                icon: Icons.person,
                label: 'Current Hiring',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRouteName.getStarted);
                },
              ),


              
           
               MyButton(
                icon: Icons.person,
                label: 'Login or Register',
                onPressed: () {
                      if(username=="Guest"){
                  Navigator.pushReplacementNamed(context, AppRouteName.loginscreen);
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('You are already logged in.'),

    ),
  );

                      }
                },
              ),

               MyButton(
                icon: Icons.person,
                label: 'Search & Apply',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRouteName.HomeScreen2);
                },
              ),
                MyButton(
                icon: Icons.person,
                label: 'Search My Status',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRouteName.RecordView);
                },
              ),
                MyButton(
                icon: Icons.person,
                label: 'Add Expereince',
                onPressed: () {
                    if(username!="Guest"){
                  Navigator.pushReplacementNamed(context, AppRouteName.CreateJobseekerExperience);

                  }
                  
                         else
                      {
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
                  }

                },
              ),
      

      MyButton(
        icon: Icons.person,
        label: 'My Job Status',
        onPressed: () {
                     if(username!="Guest"){
          Navigator.pushReplacementNamed(context, AppRouteName.ApplicantDetailsScreen);

           }
                  
                         else
                      {
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
                  }

                },
              ),
      
      MyButton(
        icon: Icons.school,
        label: 'Edit Education',
        onPressed: () {
             if(username!="Guest"){
          Navigator.pushReplacementNamed(context, AppRouteName.CreateJobseekerEducation);
             }
             else
                      {
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
                  }

                },
              ),
      MyButton(
        icon: Icons.work,
        label: 'Edit Experience',
        onPressed: () {
            if(username!="Guest"){
Navigator.pushReplacementNamed(context, AppRouteName.CreateJobseekerExperience);
             }
                 else
                      {
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
                  }

                },
              ),
      MyButton(
        icon: Icons.upload,
        label: 'Upload Documents',
        onPressed: () {
          if(username!="Guest"){
          Navigator.pushReplacementNamed(context, AppRouteName.UploadDocumentView);
       }
                 else
                      {
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
                  }

                },
              ),
    ]
 

          
          ),
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

class MyButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const MyButton({super.key, required this.icon, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64.0,
              color: Colors.white,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
