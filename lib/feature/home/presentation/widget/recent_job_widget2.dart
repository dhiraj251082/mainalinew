import 'package:flutter/material.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/model/JobPostingModel.dart';
import 'package:mainalihr/utility/job_postings_controller.dart';

// Make sure to import necessary packages and models

class RecentJobWidget2 extends StatefulWidget {
  final String? location;
  final String? industry;
  final Function(bool) onSearchComplete;

  const RecentJobWidget2({
    super.key,
    this.location,
    this.industry,
    required this.onSearchComplete,
  });

  @override
  State<RecentJobWidget2> createState() => _RecentJobWidget2State();
}


class _RecentJobWidget2State extends State<RecentJobWidget2> {
  late Future<List<JobPostingModel>> jobPostings;

  @override
  void initState() {
    super.initState();
    _updateJobPostings();
  }

  @override
  void didUpdateWidget(covariant RecentJobWidget2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.location != widget.location || oldWidget.industry != widget.industry) {
      _updateJobPostings();
    }
  }

  void _updateJobPostings() {
  setState(() {
    // Set _searching to true before fetching job postings
    widget.onSearchComplete(true);
  });

  if (widget.location != null && widget.industry != null) {
    jobPostings = JobPostingsController().filterJobPostings2(
      widget.industry!,
      widget.location!,
    );
  } else {
    jobPostings = JobPostingsController().fetchJobPostings();
  }

  // Set _searching to false after providing the output
  Future.delayed(Duration.zero, () {
    widget.onSearchComplete(false);
  });
}


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.location != null && widget.industry != null)
          Text(
            'Searching in location ${widget.location} in Industry ${widget.industry}...',
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 18),
          ),
        FutureBuilder<List<JobPostingModel>>(
          future: jobPostings,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No job postings found.'));
            } else {
              return Expanded(
                child: ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    JobPostingModel jobPosting = snapshot.data![index];
                    return JobPostingListItem(jobPosting: jobPosting);
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
class JobPostingListItem extends StatelessWidget {
  final JobPostingModel jobPosting;

  const JobPostingListItem({super.key, required this.jobPosting});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouteName.detailJob,
          arguments: jobPosting,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobPosting.companyName ?? '',
                    style: const TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.place_outlined, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        jobPosting.locationName ?? '',
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.card_travel_rounded, size: 20),
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
            const Icon(Icons.bookmark_border_rounded),
          ],
        ),
      ),
    );
  }
}
