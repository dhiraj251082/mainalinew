import 'package:flutter/material.dart';
import 'package:mainalihr/common/user_provider.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/model/JobApplyModel.dart'; // Import JobApplyModel
import 'package:mainalihr/model/JobPostingModel.dart';
import 'package:mainalihr/screen/jobstatus/ClientJobApplyStatus.dart';
import 'package:mainalihr/utility/search_service.dart';
import 'package:provider/provider.dart';

class ClientDetailsScreen extends StatefulWidget {
  const ClientDetailsScreen({super.key});

  @override
  _ClientDetailsScreenState createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  late Future<ClientDetails> _future;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userCredentials = userProvider.userCredentials;
    final userid = userCredentials?.userId ?? "Guest";
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This disables the automatic back button
        title: const Text('Your Demand Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRouteName.clientNavigation);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<ClientDetails>(
          future: SearchService.fetchdemands(userid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("snapshot.hasError: ${snapshot.error}");
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final clientDetails = snapshot.data!;
              final groupedJobPostings = groupJobPostingsByDemandId(clientDetails.jobPostings);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: groupedJobPostings.entries.map((entry) {
                  final demandId = entry.key;
                  final jobPostings = entry.value;

                    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black), // Add border to each demand entry
        borderRadius: BorderRadius.circular(10), // Add border radius for rounded corners
      ),
       margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Demand ID: $demandId',
                 style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Increase font size and bold style
                      ),
                      for (var jobPosting in jobPostings)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return ClientApplyStatus(
                                jobPostings: clientDetails.jobPostings,
                                jobApplies: clientDetails.jobApplies,
                                demand_id: jobPosting.demand_id.toString(),
                                jobId: jobPosting.jobId.toString(),
                              );
                            }));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Profession: ${jobPosting.professionName}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        'Job ID: ${jobPosting.jobId}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        'Min Age: ${jobPosting.minAge}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        'Max Age: ${jobPosting.maxAge}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        'Gender: ${jobPosting.gender}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      // Add other relevant details here
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  'Job Applies: ${getJobAppliesCount(clientDetails.jobApplies, jobPosting.jobId.toString())}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }

  Map<String, List<JobPostingModel>> groupJobPostingsByDemandId(List<JobPostingModel> jobPostings) {
    final groupedJobPostings = <String, List<JobPostingModel>>{};

    for (var jobPosting in jobPostings) {
      final demandId = jobPosting.demand_id.toString();
      if (groupedJobPostings.containsKey(demandId)) {
        groupedJobPostings[demandId]!.add(jobPosting);
      } else {
        groupedJobPostings[demandId] = [jobPosting];
      }
    }

    return groupedJobPostings;
  }

  int getJobAppliesCount(List<JobApply> jobApplies, String jobId) {
    return jobApplies.where((apply) => apply.jobId == jobId).length;
  }
}
