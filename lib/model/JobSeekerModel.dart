// models/job_seeker.dart

// models/job_seeker_model.dart
class JobSeekerModel {
 late final int applicantId;
  late final String applicantName;
  late final String gender;
  late final List<String> fullLengthPhotoUrls;
  late final List<String> passportPhotoUrls;
  late final List<ExperienceModel> experiences;
  late final List<EducationModel> educations;

  JobSeekerModel({
    required this.applicantId,
    required this.applicantName,
    required this.gender,
    required this.fullLengthPhotoUrls,
    required this.passportPhotoUrls,
    required this.experiences,
    required this.educations,
  });

  factory JobSeekerModel.fromJson(Map<String, dynamic> json) {
    return JobSeekerModel(
      applicantId: json['applicant_id'],
    applicantName: json['applicant_name'],
    gender: json['gender'],
    fullLengthPhotoUrls: List<String>.from(json['full_length_photo_urls'] ?? []),
    passportPhotoUrls: List<String>.from(json['passport_photo_urls'] ?? []),
    experiences: (json['experiences'] as List<dynamic>?)
        ?.map((exp) => ExperienceModel.fromJson(exp))
        .toList() ?? [],
    educations: (json['educations'] as List<dynamic>?)
        ?.map((edu) => EducationModel.fromJson(edu))
        .toList() ?? [],
  );
  }
}

class ExperienceModel {
  final String companyName;
  final String industry;
  final String profession;
  final String joiningDate;
  final String relivingDate;
  final int location;

  ExperienceModel({
    required this.companyName,
    required this.industry,
    required this.profession,
    required this.joiningDate,
    required this.relivingDate,
    required this.location,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
       companyName: json['company_name'] ?? '',
    industry: json['industry'] ?? '',
    profession: json['profession'] ?? '',
    joiningDate: json['joining_date'] ?? '',
    relivingDate: json['reliving_date'] ?? '',
    location: json['location'] ?? 0,
    );
  }

  toJson() {}
}

class EducationModel {
  final String instituteName;
  final String level;

  EducationModel({
    required this.instituteName,
    required this.level,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
       instituteName: json['institute_name'] ?? '',
    level: json['level'] ?? '',
    );
  }

  toJson() {}
}
