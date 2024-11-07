import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/feature/home/presentation/widget/headline_widget.dart';
import 'package:mainalihr/feature/home/presentation/widget/recent_job_widget.dart';
//import 'package:mainalihr/feature/home/presentation/widget/tips_widget.dart';.
import 'package:mainalihr/feature/home/presentation/widget/tips_widget.dart';
import 'package:provider/provider.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    // Retrieve the user credentials from the provider
    final userCredentials = userProvider.userCredentials;
    print("i am in recent");
    
    // Extract the name from the user credentials if available
    final userName = userCredentials?.name ?? "Guest";
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          onPressed: () {
              Navigator.pushReplacementNamed(context, AppRouteName.jobSeekerNavigation);

          },
          splashRadius: 24,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Hi, $userName", // Display the user's name in the app bar
          style: Theme.of(context).textTheme.headlineMedium
        ),
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 24,
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            child: Container(
              height: 56,
              width: MediaQuery.of(context).size.width - 48,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.center,
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Developer, google, etc",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tips Widget
          
              HeadlineWidget(title: "Tips for you"),
            SizedBox(height: 16),
            TipsWidget(),

            // Category
           /* const SizedBox(height: 24),
            const HeadlineWidget(title: "Category"),
            const SizedBox(height: 16),
            const CategoryWidget(),*/
            // Recent Job
            SizedBox(height: 24),
            HeadlineWidget(title: "Recent Jobs"),
            SizedBox(height: 16),
            RecentJobWidget(searching: true,), // This widget should now be able to handle JobPostingModel data
          ],
        ),
      ),
    );
  }
}
