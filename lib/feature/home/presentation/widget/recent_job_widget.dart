import 'package:flutter/material.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/model/JobPostingModel.dart';
import 'package:mainalihr/utility/job_postings_controller.dart';

class RecentJobWidget extends StatefulWidget {
  final bool searching;
  final String? location;
  final String? job;

  const RecentJobWidget({
    super.key,
    required this.searching, // Remove default value and mark as required
    this.location,
    this.job,
  });


  @override
  State<RecentJobWidget> createState() => _RecentJobWidgetState();
}

class _RecentJobWidgetState extends State<RecentJobWidget> {
  late Future<List<JobPostingModel>> jobPostings;

  @override
  void initState() {
    super.initState();
    print('widget.searching in initstate:${widget.searching}');
    if (widget.searching) {
      jobPostings = JobPostingsController().filterJobPostings();
    } else {
      jobPostings = JobPostingsController().fetchJobPostings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.searching ? ' in ${widget.location}in ${widget.job}...' : 'Select',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
        FutureBuilder<List<JobPostingModel>>(
          future: jobPostings,
          builder: (context, snapshot) {
            print('Snapshot connection state Contact Mainali Support: ${snapshot.connectionState}');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error snapshot.hasError Contact Mainali Support: ${snapshot.error}.Field: fieldName', style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 207, 30, 30))));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No job postings found.'));
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.6, // Adjust the height as needed
                child: ListView.separated(
                 // shrinkWrap: true,
                //  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    JobPostingModel jobPosting = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRouteName.detailJob,
                          arguments: jobPosting,
                        );
                      },
                      child: Container(
                        height: 86,
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jobPosting.companyName ?? '', 
                                    style: const TextStyle(color: Color.fromARGB(255, 220, 22, 22), fontSize: 20),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.place_outlined,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        jobPosting.locationName ?? '',
                                        style: const TextStyle(color: Colors.black, fontSize: 16),
                                      ),
                                      const SizedBox(width: 16),
                                      const Icon(
                                        Icons.card_travel_rounded,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        jobPosting.jobTitle ?? '',
                                        style: const TextStyle(color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.bookmark_border_rounded),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
