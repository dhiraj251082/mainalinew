class Record {
  final String? name;
  final String? passportNumber;
    final String? country;
  final String? project;
  
  final String? interviewDate;
  final String? offerLetter;
  final String? remark;

  Record({
    this.name,
    this.passportNumber,
    this.country,
    this.project,
    this.interviewDate,
    this.offerLetter,
    this.remark,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      name: json['name'] as String?,      
      passportNumber: json['passport_number'] as String?,
          country: json['country'] as String?,

      project: json['project'] as String?,
      interviewDate: json['interview_date'] as String?,
      offerLetter: json['offer_letter'] as String?,
      remark: json['remark'] as String?,
    );
  }
}
