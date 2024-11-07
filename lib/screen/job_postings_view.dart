import 'package:flutter/material.dart';
import 'package:mainalihr/model/JobPostingModel.dart';
import 'package:mainalihr/utility/job_postings_controller.dart';

class GetAllJobPostingsView extends StatefulWidget {
  const GetAllJobPostingsView({super.key});

  @override
  _GetAllJobPostingsViewState createState() => _GetAllJobPostingsViewState();
}

class _GetAllJobPostingsViewState extends State<GetAllJobPostingsView> {
  final JobPostingsController jobPostingsController = JobPostingsController();

  late Future<List<JobPostingModel>> jobPostings;
  TextEditingController applicationIdController = TextEditingController(); // Add this line
  String applicationId = ""; // State to hold the application ID

  @override
  void initState() {
    super.initState();
    jobPostings = jobPostingsController.fetchJobPostings();
  }

  Future<void> sendApplication(String applicationId, int jobId) async {
    // You need to implement the logic to send the application ID and job ID to your backend here
    // For example, you can make an HTTP request to your backend API
    // Make sure to handle errors and display appropriate messages to the user

    
    print('Sending application for application ID: $applicationId and job ID: $jobId');



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Job Postings', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.red],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text field for entering application ID
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: applicationIdController,
                decoration: const InputDecoration(
                  labelText: 'Enter Application ID',
                ),
              ),
            ),
            // Display Application ID Text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Application ID: $applicationId',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<JobPostingModel>>(
                future: jobPostings,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(fontSize: 18, color: Colors.white)));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No job postings found.', style: TextStyle(fontSize: 18, color: Colors.white)));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        JobPostingModel jobPosting = snapshot.data![index];
                        return Card(
                          color: Colors.white70,
                          child: ListTile(
                            title: const Text('Below is your Job Posting', style: TextStyle(color: Colors.black, fontSize: 20)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Company Name: ${jobPosting.companyName}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                Text('Job Title: ${jobPosting.jobTitle}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                // Add Apply Button
                               ElevatedButton(
  onPressed: () {
    setState(() {
    //  String jobId = jobPosting.jobId;
   //   jobPosting.applicationId = applicationIdController.text;
     // jobPostingsController.sendApplication(applicationIdController.text, jobId); // Call the sendApplication method
     
    });
  },
  child: const Text('Apply'),
),
                                const SizedBox(height: 8),
                                Text('Job ID: ${jobPosting.jobId}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                Text('Industry: ${jobPosting.industryName}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                Text('Profession: ${jobPosting.professionName}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                Text('Job Description: ${jobPosting.jobDescription}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                Text('Location: ${jobPosting.locationName}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                Text('Salary: ${jobPosting.salary}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                Text('Minimum Qualification: ${jobPosting.minimumQualification}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                Text('Gender: ${jobPosting.gender}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                                Text('Age Range: ${jobPosting.minAge} - ${jobPosting.maxAge}', style: const TextStyle(color: Colors.black, fontSize: 16)),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
