import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/feature/home/presentation/widget/recent_job_widget2.dart';
import 'package:mainalihr/feature/home/presentation/widget/search_job_widget.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  String? _selectedLocation;
  String? _selectedIndustry;
  bool _searching = false; // Initialize to false initially

  void _handleSearch(String? industry, String? location) {
    setState(() {
      print("searching now");
      _selectedLocation = location ?? '';
      _selectedIndustry = industry ?? '';
      _searching = true;
      // Set to true when searching starts
    });
  }

  @override
  Widget build(BuildContext context) {
    //  print("searching Status now $_searching");
    _selectedLocation ??= '';
    _selectedIndustry ??= '';
    return Scaffold(
      appBar: AppBar(
       title:  Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRouteName.jobSeekerNavigation);
    
              },
            ),
            const SizedBox(width: 8), // Add some space between the back button and the title
            const Text('Current Hiring'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchWidget(
              onSearch: _handleSearch,
            ),
            const Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: RecentJobWidget2(
                location: _selectedLocation,
                industry: _selectedIndustry,
                onSearchComplete: (isSearching) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    setState(() {
                      _searching = isSearching;
                    });
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
