// complete_job_seeker_model.dart

class CompleteJobSeekerModel {
  final int id;
  final String applicantId; // Assuming applicant_id is stored as VARCHAR
  final String applicantName;
  final String gender;
  final List<String> fullLengthPhotoUrls;
  final List<String> passportPhotoUrls;
  final List<ExperienceModel> experiences;
  final List<EducationModel> educations;
  final DateTime? createdAt; // Optional
  final DateTime? updatedAt; // Optional
  final DateTime? dateOfBirth; // Optional
  // Constructor
  CompleteJobSeekerModel({
    required this.id,
    required this.applicantId,
    required this.applicantName,
    required this.gender,
    required this.fullLengthPhotoUrls,
    required this.passportPhotoUrls,
    required this.experiences,
    required this.educations,
    this.createdAt, // Optional
    this.updatedAt, // Optional
    this.dateOfBirth, // Optional// Include dateOfBirth in constructor
  });

  // Factory method to create a CompleteJobSeekerModel from JSON
  factory CompleteJobSeekerModel.fromJson(Map<String, dynamic> json) {
    return CompleteJobSeekerModel(
      id: json['id'] ?? 0,
      applicantId: json['applicant_id'] ?? '',
      applicantName: json['applicant_name'] ?? '',
      gender: json['gender'] ?? '',
      fullLengthPhotoUrls: json['full_length_photo_urls'] != null
          ? List<String>.from(json['full_length_photo_urls'])
          : [],
      passportPhotoUrls: json['passport_photo_urls'] != null
          ? List<String>.from(json['passport_photo_urls'])
          : [],
      experiences: json['experiences'] != null
          ? (json['experiences'] as List<dynamic>)
              .map((exp) => ExperienceModel.fromJson(exp))
              .toList()
          : [],
      educations: json['educations'] != null
          ? (json['educations'] as List<dynamic>)
              .map((edu) => EducationModel.fromJson(edu))
              .toList()
          : [],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null, // Handle optional date
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null, // Handle optional date
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.tryParse(json['date_of_birth'])
          : null, // Handle optional datearse date_of_birth
    );
  }

  // Method to convert CompleteJobSeekerModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'applicant_id': applicantId,
      'applicant_name': applicantName,
      'gender': gender,
      'full_length_photo_urls': fullLengthPhotoUrls,
      'passport_photo_urls': passportPhotoUrls,
      'experiences': experiences.map((exp) => exp.toJson()).toList(),
      'educations': educations.map((edu) => edu.toJson()).toList(),
      'created_at': createdAt?.toIso8601String(), // Nullable field handled with ?.
      'updated_at': updatedAt?.toIso8601String(), // Nullable field handled with ?.
      'date_of_birth': dateOfBirth?.toIso8601String(), // Nullable field handled with ?.
    };
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

  // Factory method to create ExperienceModel from JSON
  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      companyName: json['company_name'] ?? '',
      industry: json['industry'] ?? '',
      profession: json['profession'] ?? '',
      joiningDate: json['joining_date'] ?? '',
      relivingDate: json['reliving_date'] ?? '',
      location: int.tryParse(json['location'].toString()) ?? 0,
    );
  }

  // Method to convert ExperienceModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
      'industry': industry,
      'profession': profession,
      'joining_date': joiningDate,
      'reliving_date': relivingDate,
      'location': location,
    };
  }
}

class EducationModel {
  final String instituteName;
  final String level;

  EducationModel({
    required this.instituteName,
    required this.level,
  });

  // Factory method to create EducationModel from JSON
  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      instituteName: json['institute_name'] ?? '',
      level: json['level'] ?? '',
    );
  }

  // Method to convert EducationModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'institute_name': instituteName,
      'level': level,
    };
  }
}
