import 'package:flutter/material.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/core/theme/app_color.dart';
import 'package:mainalihr/core/theme/app_theme.dart';

class clientNavigation extends StatelessWidget {
  const clientNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRouteName.mainScreen);
              },
            ),
            const SizedBox(width: 8), // Add some space between the back button and the title
            const Text('Client Dashboard'),
          ],
        ),
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
                  label: 'Show Client Enquiry',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRouteName.SelectedApplicantsScreen);
                  },
                ),
                MyButton(
                  icon: Icons.school,
                  label: 'Job Seeker Status',
                    onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRouteName.GetAllJobSeekersView);
                  },
                ),
                MyButton(
                  icon: Icons.work,
                  label: 'Register',
                    onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRouteName.CreateJobseekerExperience);
                  },
                ),
                MyButton(
                icon: Icons.person,
                label: 'Message to CEO',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRouteName.loginscreen);
                },
              ),
                MyButton(
                  icon: Icons.upload,
                  label: 'More Fuction',
                    onPressed: () {
                         Navigator.pushReplacementNamed(context, AppRouteName.SearchJobSeeker);
 
                  },
                ),
              ],
            ),
          ),
        ),
      ),
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
