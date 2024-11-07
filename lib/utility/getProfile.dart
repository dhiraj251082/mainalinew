// profile_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<Map<String, dynamic>> fetchProfileData() async {
    final response = await http.get(Uri.parse('http://192.168.1.6/api/applicant/20231214123343'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  List<Map<String, String>> parseEducationData(List<dynamic>? educationData) {
    if (educationData == null || educationData.isEmpty) {
      return [
        {'Institution': 'Data not found'},
        {'Level': 'Data not found'},
        {'Year of Passing': 'Data not found'},
        {'Specialization': 'Data not found'},
        {'Grade Percentage': 'Data not found'},
      ];
    }

    return educationData.map<Map<String, String>>((edu) {
      return {
        'Institution': edu['institute_name']?.toString() ?? 'Data not found',
        'Level': edu['level']?.toString() ?? 'Data not found',
        'Year of Passing': edu['year_of_passing']?.toString() ?? 'Data not found',
        'Specialization': edu['specialization']?.toString() ?? 'Data not found',
        'Grade Percentage': edu['grade_percentage']?.toString() ?? 'Data not found',
      };
    }).toList();
  }

  List<Map<String, String>> parseExperienceData(List<dynamic>? experienceData) {
    if (experienceData == null || experienceData.isEmpty) {
      return [
        {'Company': 'Data not found'},
        {'Role': 'Data not found'},
        {'Start Date': 'Data not found'},
        {'End Date': 'Data not found'},
        {'Description': 'Data not found'},
      ];
    }

    return experienceData.map<Map<String, String>>((exp) {
      return {
        'Company': exp['company_name']?.toString() ?? 'Data not found',
        'Role': exp['role']?.toString() ?? 'Data not found',
        'Start Date': exp['start_date']?.toString() ?? 'Data not found',
        'End Date': exp['end_date']?.toString() ?? 'Data not found',
        'Description': exp['description']?.toString() ?? 'Data not found',
      };
    }).toList();
  }

  List<Map<String, String>> parseDocumentData(List<dynamic>? documentData) {
    if (documentData == null || documentData.isEmpty) {
      return [
        {'Document Type': 'Data not found'},
        {'Document Number': 'Data not found'},
      ];
    }

    return documentData.map<Map<String, String>>((doc) {
      return {
        'Document Type': doc['document_type']?.toString() ?? 'Data not found',
        'Document Number': doc['document_number']?.toString() ?? 'Data not found',
      };
    }).toList();
  }
}
