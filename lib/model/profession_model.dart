class Profession {
  final int id;
  final String professionName;
  final int industryId;

  Profession({
    required this.id,
    required this.professionName,
    required this.industryId,
  });

  factory Profession.fromJson(Map<String, dynamic> json) {
    return Profession(
      id: json['id'],
      professionName: json['profession_name'],
      industryId: json['industry_id'],
    );
  }

  @override
  String toString() {
    return 'Profession{id: $id, professionName: $professionName, industryId: $industryId}';
  }
}
