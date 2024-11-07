import 'package:flutter/material.dart';
import 'package:mainalihr/ui/image_viewer.dart';
import 'package:mainalihr/utility/getProfile.dart';



class ProfileUI extends StatefulWidget {
  const ProfileUI({super.key});

  @override
  _ProfileUIState createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  final Map<String, String> _sectionContent = {
    'Personal': '',
    'Education': '',
    'Experience': '',
    'Document': '',
  };

  final List<bool> _isExpanded = [false, false, false, false];

  final ProfileService _profileService = ProfileService();
  String applicantName = 'Profile'; // Default value
  String? passportSizePhotoUrl; // Variable to store passport photo URL

  @override
  void initState() {
    super.initState();
    fetchAndDisplayProfileData();
  }

  Future<void> fetchAndDisplayProfileData() async {
    try {
      final profileData = await _profileService.fetchProfileData();
      print(profileData); // Print all data in the console

      setState(() {
        final personalDetails = profileData['personal'] as Map<String, dynamic>?;
        if (personalDetails != null) {
          applicantName = personalDetails['applicant_name'] ?? 'Profile';
          final documentDetails = profileData['document'].first as Map<String, dynamic>;
          String baseUrl = 'http://192.168.1.6/storage/'; // Replace with your actual base URL
          passportSizePhotoUrl = baseUrl + (documentDetails['passport_size_photo'] ?? '');
          _sectionContent['Personal'] = '''
            Name: ${personalDetails['applicant_name'] ?? 'Data not found'}
            Father/Spouse Name: ${personalDetails['father_spouse_name'] ?? 'Data not found'}
            Date of Birth: ${personalDetails['date_of_birth'] ?? 'Data not found'}
            Gender: ${personalDetails['gender'] ?? 'Data not found'}
            Marital Status: ${personalDetails['marital_status'] ?? 'Data not found'}
            Height: ${personalDetails['height'] ?? 'Data not found'}
            Weight: ${personalDetails['weight'] ?? 'Data not found'}
            Address: ${personalDetails['addressline1'] ?? 'Data not found'}
            Pincode: ${personalDetails['pincode'] ?? 'Data not found'}
            District: ${personalDetails['district'] ?? 'Data not found'}
            State: ${personalDetails['state'] ?? 'Data not found'}
            Email: ${personalDetails['email'] ?? 'Data not found'}
            Phone No: ${personalDetails['phone_no'] ?? 'Data not found'}
            WhatsApp No: ${personalDetails['whatsapp_no'] ?? 'Data not found'}
            Passport No: ${personalDetails['passport_no'] ?? 'Data not found'}
            Passport Expiry Date: ${personalDetails['passport_expire_date'] ?? 'Data not found'}
          ''';
        }

        final educationList = profileData['education'] as List<dynamic>?;
        if (educationList != null && educationList.isNotEmpty) {
          final educationDetails = educationList.first as Map<String, dynamic>;
          _sectionContent['Education'] = '''
            Institute Name: ${educationDetails['institute_name'] ?? 'Data not found'}
            Level: ${educationDetails['level'] ?? 'Data not found'}
            Year of Passing: ${educationDetails['year_of_passing'] ?? 'Data not found'}
            Specialization: ${educationDetails['specialization'] ?? 'Data not found'}
            Grade Percentage: ${educationDetails['grade_percentage'] ?? 'Data not found'}
          ''';
        }

        final experienceList = profileData['experience'] as List<dynamic>?;
        if (experienceList != null && experienceList.isNotEmpty) {
          final experienceDetails = experienceList.first as Map<String, dynamic>;
          _sectionContent['Experience'] = '''
            Company Name: ${experienceDetails['company_name'] ?? 'Data not found'}
            Joining Date: ${experienceDetails['joining_date'] ?? 'Data not found'}
            Relieving Date: ${experienceDetails['reliving_date'] ?? 'Data not found'}
            Job Description: ${experienceDetails['job_discription'] ?? 'Data not found'}
          ''';
        }

        final documentList = profileData['document'] as List<dynamic>?;
        if (documentList != null && documentList.isNotEmpty) {
          final documentDetails = documentList.first as Map<String, dynamic>;
          String baseUrl = 'http://192.168.1.6/storage/';
          _sectionContent['Document'] = '''
            Passport Front: ${documentDetails['passport_front'] ?? ''}
            Passport Back: ${documentDetails['passport_back'] ?? ''}
            Passport Full: ${documentDetails['passport_full'] ?? ''}
            Passport Status: ${documentDetails['passport_status'] ?? 'Data not found'}
            Experience Document: ${documentDetails['experience'] ?? ''}
            Technical Qualification: ${documentDetails['technical_qualification'] ?? ''}
            Full Length Photo Size: ${documentDetails['full_length_photo_size'] ?? ''}
            Passport Size Photo: ${documentDetails['passport_size_photo'] ?? ''}
          ''';
        }
      });
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(applicantName),
        centerTitle: true, // Center the title in the AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (passportSizePhotoUrl != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(passportSizePhotoUrl!),
                  radius: 70, // Displaying a larger image
                ),
              ),
            ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: const EdgeInsets.all(0),
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _isExpanded[index] = !_isExpanded[index];
                });
              },
              children: _sectionContent.keys.toList().asMap().entries.map<ExpansionPanel>((entry) {
                int index = entry.key;
                String headerTitle = entry.value;
                String content = _sectionContent[headerTitle] ?? '';

                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(headerTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
                    );
                  },
                  body: _isExpanded[index]
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: content.split('\n').map((line) {
                              if (line.trim().startsWith('Passport Front:') ||
                                  line.trim().startsWith('Passport Back:') ||
                                  line.trim().startsWith('Passport Full:') ||
                                  line.trim().startsWith('Full Length Photo Size:') ||
                                  line.trim().startsWith('Passport Size Photo:')) {
                                String label = line.split(':').first.trim();
                                String url = line.split(':').last.trim();
                                String fullUrl = 'http://192.168.1.6/storage/$url';
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        label, // Display the name of the document
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigate to the ImageViewer screen with the image URL
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ImageViewer(imageUrl: fullUrl),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          fullUrl, // Display the clickable URL
                                          style: const TextStyle(
                                            color: Colors.blue, // Indicating it's clickable
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (line.trim().endsWith('.pdf')) {
                                String label = line.split(':').first.trim();
                                String url = line.split(':').last.trim();
                                String fullUrl = 'http://192.168.1.6/storage/$url';
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        label, // Display the name of the document
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigate to the PDFViewer screen with the PDF URL
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                        builder: (context) => ImageViewer(imageUrl: fullUrl),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          fullUrl, // Display the clickable URL
                                          style: const TextStyle(
                                            color: Colors.blue, // Indicating it's clickable
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    line,
                                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                                  ),
                                );
                              }
                            }).toList(),
                          ),
                        )
                      : Container(), // Empty container when collapsed
                  isExpanded: _isExpanded[index],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
