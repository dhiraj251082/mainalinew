class JobPostingModel {

  final int? jobId;
  final String? companyName;
  final String? jobTitle;
  final String? industryName;
  final String? professionName;
  final String? jobDescription;
   final String? industryid;
  final String? locationName;
   final String? locationid;
  final String? salary;
  final String? minimumQualification;
  final String? gender;
  final String? minAge;
  final String? maxAge;
  final bool? accomodation;
  final bool? food;
  final DateTime? interviewdate; // Change type to DateTime
  final bool? transport;
    final String? demand_id;
   final DateTime? created_at;
    




  JobPostingModel({

    this.jobId,
    this.companyName,
    this.jobTitle,
    this.industryName,
     this.industryid,
    this.professionName,
    this.jobDescription,
    this.locationName,
    this.locationid,
    this.salary,
    this.minimumQualification,
    this.gender,
    this.minAge,
    this.maxAge,
    this.accomodation,
    this.food,
    this.interviewdate, // Change type to DateTime
    this.transport,
    this.demand_id,
    this.created_at,
  });

factory JobPostingModel.fromJson(Map<String, dynamic> json) {
  return JobPostingModel(
    jobId: int.tryParse(json['job_id']?.toString() ?? '') ?? 0,
    companyName: json['company_name'] ?? '',
    jobTitle: json['job_title'] ?? '',
    industryid: json['industryid']?.toString() ?? '',
    industryName: json['industry_name'] ?? '',
    professionName: json['profession_name'] ?? '',
    jobDescription: json['job_description'] ?? '',
    locationName: json['location_name'] ?? '',
    locationid: json['locationid']?.toString() ?? '',
    salary: json['salary'] ?? '',
    minimumQualification: json['minimum_qualification'] ?? '',
    gender: json['gender'] ?? '',
    minAge: json['min_age']?.toString() ?? '',
    maxAge: json['max_age']?.toString() ?? '',
    accomodation: json['accomodation'] == 'on', // Convert 'accomodation' string to bool
    food: json['food'] == 'on', // Convert 'food' string to bool
    interviewdate: json['interviewdate'] != null ? DateTime.tryParse(json['interviewdate'].toString()) : null,
    transport: json['transport'] == 'on',
      demand_id: json['demand_id'] ?? '',
      created_at: json['created_at'] != null ? DateTime.tryParse(json['created_at'].toString()) : null, // Convert 'transport' string to bool
  );
}

  

  Map<String, dynamic> toJson() {
    return {

      'job_id': jobId,
      'company_name': companyName,
      'job_title': jobTitle,
      'industry_name': industryName,
      'industryid': industryid,
      'profession_name': professionName,
      'job_description': jobDescription,
      'location_name': locationName,
      'locationid' :locationid,
      'salary': salary,
      'minimum_qualification': minimumQualification,
      'gender': gender,
      'min_age': minAge,
      'max_age': maxAge,
       'accomodation': accomodation,
              'food': food,
                     'interviewdate': interviewdate?.toIso8601String(),
                              'transport': transport,
                               'demand_id': demand_id,
                                'created_at': created_at?.toIso8601String(),


    };
  }

  @override
  String toString() {
    return 'JobPostingModel{'
        'jobId: $jobId, '
        'companyName: $companyName, '
        'jobTitle: $jobTitle, '
        'industryName: $industryName, '
        'professionName: $professionName, '
        'jobDescription: $jobDescription, '
        'industryid: $industryid, '
        'locationName: $locationName, '
        'locationid: $locationid, '
        'salary: $salary, '
        'minimumQualification: $minimumQualification, '
        'gender: $gender, '
        'minAge: $minAge, '
        'maxAge: $maxAge, '
        'accomodation: $accomodation, '
        'food: $food, '
        'interviewdate: $interviewdate, '
        'transport: $transport'
         'demand_id: $demand_id,'
          'created_at: $created_at,'
         
        '}';
  }

}
