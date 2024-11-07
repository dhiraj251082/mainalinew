import 'package:flutter/material.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/model/JobApplyModel.dart';
import 'package:mainalihr/model/JobPostingModel.dart';

class ClientApplyStatus extends StatelessWidget {
  final String demand_id;
  final List<JobApply> jobApplies;
  final List<JobPostingModel> jobPostings;
  final String jobId; // Define jobId as a named parameter

  const ClientApplyStatus({super.key, required this.jobPostings, required this.jobApplies, required this.demand_id,required this.jobId});

  @override
  Widget build(BuildContext context) {
    print('Demand ID: $demand_id');
    print('Job Postings: $jobPostings');
    print('Job Applies: $jobApplies\n\n');

    // Filter job postings based on the demand_id
    List<JobPostingModel> filteredJobPostings = jobPostings.where((posting) => posting.demand_id == demand_id).toList();

    // Create a map to efficiently store job posting details (including profession) by jobId
    Map<String, JobPostingModel> jobPostingMap = {};
    for (var posting in jobPostings) {
      jobPostingMap[posting.jobId.toString()] = posting;
    }

    print("Filtered Job Postings: $filteredJobPostings\n\n");
    List<JobApply> filteredJobApplies = [];
  // Filter job applies based on jobId
 filteredJobApplies = jobApplies.where((apply) => apply.jobId == jobId).toList();

    print("Filtered Job Applies: $filteredJobApplies");

    return Scaffold(
      appBar: AppBar(
automaticallyImplyLeading: false, // This disables the automatic back button
  title: const Text('Your Demand Details'),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pushReplacementNamed(context, AppRouteName.ClientDetailsScreen);
    },
  ),
       
      ),
      body: ListView.builder(
        itemCount: filteredJobApplies.length,
        itemBuilder: (context, index) {
          final jobApply = filteredJobApplies[index];

          // Access profession efficiently from the jobPostingMap
          String profession = "";
          if (jobPostingMap.containsKey(jobApply.jobId)) {
            profession = jobPostingMap[jobApply.jobId]!.professionName.toString();
          }

          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Job ID: ${jobApply.jobId}'),
                        Text('Applicant ID: ${jobApply.applicantId}'),
                        Text('Visa Status: ${jobApply.visaStatus}'),
                        Text('Job Status: ${jobApply.jobStatus}'),
                        Text('Profession: $profession'), // Display profession
                        // Add more details here
                      ],
                    ),
                  ),
                  const SizedBox(width: 16), // Add some space between columns
                  const Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Add more details here if needed
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 