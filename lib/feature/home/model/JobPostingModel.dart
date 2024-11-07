class JobPostingModel {
 final String jobId;
  final String companyName;
  final String jobTitle;
  final String industryName;
  final String professionName;
  final String jobDescription;
  final String locationName;
  final String salary;
  final String minimumQualification;
  final String gender;
  final String minAge;
  final String maxAge;
  final bool accomodation;
  final bool food;
  final DateTime? interviewdate; // Change type to DateTime
  final bool transport;

  String applicationId;

  JobPostingModel({
    required this.applicationId,
    required this.jobId,
    required this.companyName,
    required this.jobTitle,
    required this.industryName,
    required this.professionName,
    required this.jobDescription,
    required this.locationName,
    required this.salary,
    required this.minimumQualification,
    required this.gender,
    required this.minAge,
    required this.maxAge,
    required this.accomodation,
    required this.food,
    required this.interviewdate, // Change type to DateTime
    required this.transport,
  });


  factory JobPostingModel.fromJson(Map<String, dynamic> json) {
    return JobPostingModel(
      applicationId: json['applicantid'],
      jobId: json['job_id'],
      companyName: json['company_name'],
      jobTitle: json['job_title'],
      industryName: json['industry_name'],
      professionName: json['profession_name'],
      jobDescription: json['job_description'],
  locationName: json['locationName'],
      salary: json['salary'],
      minimumQualification: json['minimum_qualification'],
      gender: json['gender'],
      minAge: json['min_age'],
      maxAge: json['max_age'],
            accomodation: json['accomodation'],
              food: json['food'],
                        interviewdate: json['interviewdate'],
                              transport: json['transport'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      applicationId:applicationId,
      'job_id': jobId,
      'company_name': companyName,
      'job_title': jobTitle,
      'industry_name': industryName,
      'profession_name': professionName,
      'job_description': jobDescription,
      'location_name': locationName,
      'salary': salary,
      'minimum_qualification': minimumQualification,
      'gender': gender,
      'min_age': minAge,
      'max_age': maxAge,
       'accomodation': accomodation,
              'food': food,
                     'interviewdate': interviewdate?.toIso8601String(),
                              'transport': transport,

    };
  }
}
