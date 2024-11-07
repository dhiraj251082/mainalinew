import 'package:flutter/material.dart';
import 'package:mainalihr/utility/search_service.dart';

class SelectedApplicantsScreen extends StatefulWidget {
  const SelectedApplicantsScreen({super.key});

  @override
  _SelectedApplicantsScreenState createState() =>
      _SelectedApplicantsScreenState();
}

class _SelectedApplicantsScreenState extends State<SelectedApplicantsScreen> {
  List<Map<String, dynamic>> selectedApplicants = [];

  @override
  void initState() {
    super.initState();
    fetchSelectedApplicants();
  }

  Future<void> fetchSelectedApplicants() async {
    try {
      final groupedApplicants = await SearchService.fetchSelectedApplicants();
      setState(() {
        selectedApplicants = groupedApplicants ?? [];
      });
    } catch (e) {
      // Handle error by logging
      debugPrint('Error fetching selected applicants: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Group applicants by userid, username, gender, and max_age
    Map<String, List<Map<String, dynamic>>> groupedApplicants = {};
    for (var applicant in selectedApplicants) {
      final key = '${applicant['userid']}_${applicant['username']}_${applicant['gender']}_${applicant['max_age']}';
      groupedApplicants.putIfAbsent(key, () => []);
      groupedApplicants[key]!.add(applicant);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Applicants'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: groupedApplicants.length,
          itemBuilder: (BuildContext context, int index) {
            final key = groupedApplicants.keys.toList()[index];
            final applicants = groupedApplicants[key]!;
            final username = applicants[0]['username'] ?? 'N/A';
            final clientName = applicants[0]['client_name'] ?? 'N/A';
            final gender = applicants[0]['gender'] ?? 'N/A';
            final maxAge = applicants[0]['max_age'] ?? 'N/A';

            return GestureDetector(
              onTap: () {
                // Navigate to a new screen showing the list of application IDs
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApplicationIdsScreen(applicants: applicants),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text('Client Name $clientName'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Client Email: $username'),
                      Text('Gender: $gender'),
                      Text('Max Age: $maxAge'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ApplicationIdsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> applicants;

  const ApplicationIdsScreen({super.key, required this.applicants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Application IDs'),
      ),
      body: ListView.builder(
        itemCount: applicants.length,
        itemBuilder: (BuildContext context, int index) {
          final applicant = applicants[index];
          final applicantId = applicant['applicant_id'] ?? 'N/A';

          return ListTile(
            title: Text('Applicant ID: $applicantId'),
          );
        },
      ),
    );
  }
}
