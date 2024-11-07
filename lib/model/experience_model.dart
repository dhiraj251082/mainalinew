class Experience {
  final String applicantId;
  final String companyName;
  final String industryId;
  final String professionId;
  final String yearOfJoining;
  final String yearOfLeaving;
  final String jobDescription;
  final String locationId;

  Experience({
    required this.applicantId,
    required this.companyName,
    required this.industryId,
    required this.professionId,
    required this.yearOfJoining,
    required this.yearOfLeaving,
    required this.jobDescription,
    required this.locationId,
  });

  @override
  String toString() {
    return 'Experience(applicantId: $applicantId, companyName: $companyName, industryId: $industryId, '
        'professionId: $professionId, yearOfJoining: $yearOfJoining, yearOfLeaving: $yearOfLeaving, '
        'jobDescription: $jobDescription,$locationId)';
  }

  // Convert Experience object to JSON
  Map<String, dynamic> toJson() {
    return {
      'applicant_id': applicantId,
      'company_name': companyName,
      'industry': industryId,
      'profession': professionId,
      'joining_date': yearOfJoining,
      'relieving_date': yearOfLeaving,
      'job_description': jobDescription,
       'locationId': locationId, // Corrected the field name
      // Add other fields as needed
    };
  }

  // Factory method to create Experience object from JSON
  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      applicantId: json['applicant_id'],
      companyName: json['company_name'],
      industryId: json['industry'],
      professionId: json['profession'],
      yearOfJoining: json['joining_date'],
      yearOfLeaving: json['relieving_date'],
      jobDescription: json['job_description'],
       locationId: json['locationId'],
      // Add other fields as needed
    );
  }
}
