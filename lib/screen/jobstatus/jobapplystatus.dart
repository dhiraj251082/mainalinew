import 'package:flutter/material.dart';
import 'package:mainalihr/model/JobApplyModel.dart';

class JobApplyStatus extends StatelessWidget {
  final String jobId;
  final List<JobApply> jobApplies;

  const JobApplyStatus({super.key, required this.jobId, required this.jobApplies});

  @override
  Widget build(BuildContext context) {
    // Filter job applies based on the jobId
    List<JobApply> filteredJobApplies = jobApplies.where((apply) => apply.jobId == jobId).toList();
     
    return Scaffold(
      appBar: AppBar(
        title: Text('Job ID: $jobId'),
      ),
      body: ListView.builder(
        itemCount: filteredJobApplies.length,
        itemBuilder: (context, index) {
          final jobApply = filteredJobApplies[index];
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
                        Text('Applicant ID: ${jobApply.applicantId}'),
        
                             Text('Medical status: ${jobApply.medicalStatus}'),
                 
                        Text('Job Status: ${jobApply.jobStatus}'),
                                 Text('Offer Letter: ${jobApply.offerLetter}'),
                        
                        Text('Visa Status: ${jobApply.visaStatus}'),
                        Text('Visa Date: ${jobApply.visaDate}'),
                        Text('Visa Expiry Date: ${jobApply.visaexpiryDate}'),
                                 Text('Date of Flight: ${jobApply.flightOn}'),

       
                    
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
