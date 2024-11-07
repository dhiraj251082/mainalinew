// education_model.dart

class Education {
  final String applicantId;
  final String instituteName;
  final String level;
  final String yearOfPassing;
  final String documentLocation;
  final String specialization;
  final String gradePercentage;

  Education({
    required this.applicantId,
    required this.instituteName,
    required this.level,
    required this.yearOfPassing,
    required this.documentLocation,
    required this.specialization,
    required this.gradePercentage,
  });

  // Convert Education object to JSON
  Map<String, dynamic> toJson() {
    return {
      'applicant_id': applicantId,
      'institute_name': instituteName,
      'level': level,
      'year_of_passing': yearOfPassing,
      'document_location': documentLocation,
      'specialization': specialization,
      'grade_percentage': gradePercentage,
    };
  }
  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      applicantId: json['applicant_id']?? 0,
      instituteName: json['institute_name'] ?? 'Data not Provided',
      level: json['level']?? 'Data not Provided',
      yearOfPassing: json['year_of_passing'] ?? 'Data not Provided',
      documentLocation: json['document_location']?? 'Data not Provided',
      specialization: json['specialization']?? 'Data not Provided',
      gradePercentage: json['grade_percentage']?? 'Data not Provided',
    );
  }
}