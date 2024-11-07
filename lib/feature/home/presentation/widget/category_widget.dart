import 'package:flutter/material.dart';
import 'package:mainalihr/utility/job_postings_controller.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late Future<List<String>> professionNames;

  @override
  void initState() {
    super.initState();
    professionNames = fetchProfessionNames(); // Fetch profession names
  }

  Future<List<String>> fetchProfessionNames() async {
    final jobPostingsController = JobPostingsController();
    final jobPostings = await jobPostingsController.fetchJobPostings();
    final professionNames = jobPostings.map((job) => job.professionName ?? '').toList();
    return professionNames;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: professionNames,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Show error if occurred
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No Job catagory found.'); // Show message if no data available
        } else {
          return Wrap(
            spacing: 16,
            children: snapshot.data!.map((professionName) {
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 48 - 48) / snapshot.data!.length,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Image(
                        image: AssetImage(
                       //   'assets/ic_${snapshot.data!.indexOf(professionName)}.png',
               'assets/ic_$professionName.png',

                        ),
                        width: 36,
                        height: 36,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      professionName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
