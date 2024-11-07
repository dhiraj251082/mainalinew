import 'package:flutter/material.dart';
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/core/theme/app_color.dart';
import 'package:provider/provider.dart';

class ClientNavigation extends StatelessWidget {
  const ClientNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Retrieve the user credentials from the provider
    final userCredentials = userProvider.userCredentials;

    // Extract the name from the user credentials if available
    final username = userCredentials?.username ?? "Guest";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Dashboard'),
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
    icon: Icons.person_search, // Changed to combine 'Search' and 'Person'
    label: 'Search Candidates',
    onPressed: () {
      Navigator.pushReplacementNamed(context, AppRouteName.SearchJobSeeker);
    },
  ),
    MyButton(
    icon: Icons.search, // Changed to a search icon for 'Get All'
    label: 'Explore All Candidates',
    onPressed: () {
      Navigator.pushReplacementNamed(context, AppRouteName.GetAllJobSeekersView);
    },
  ),
  MyButton(
    icon: Icons.add_circle_outline, // Changed to represent 'Create' visually
    label: 'Create Job',
    onPressed: () {
      Navigator.pushReplacementNamed(context, AppRouteName.CreateJobseekerJobposting);
    },
  ),

  MyButton(
    icon: Icons.app_registration, // Changed to suggest 'Register'
    label: 'SignUp',
    onPressed: () {
Navigator.pushNamed(context, AppRouteName.ClientForm);
    },
  ),
   MyButton(
    icon: Icons.login, // Changed to clearly indicate 'Login'
    label: 'Login',
    onPressed: () {
      Navigator.pushReplacementNamed(context, AppRouteName.loginscreen);
    },
  ),
  MyButton(
    icon: Icons.assessment, // Changed to imply 'My Demand' or status
    label: 'My Demand',
    onPressed: () {
      if (username != "Guest") {
        Navigator.pushReplacementNamed(context, AppRouteName.ClientDetailsScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please Login For your Demand Status.'),
          ),
        );
      }
    },
  ),
 
 
  MyButton(
    icon: Icons.more_horiz, // Changed to 'More' to indicate additional options
    label: 'More Functionality',
    onPressed: () {
      Navigator.pushReplacementNamed(context, AppRouteName.SelectedApplicantsScreen);
    },
  ),
]

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
