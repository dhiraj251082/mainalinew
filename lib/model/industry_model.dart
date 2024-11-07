// industry_model.dart

class Industry {
  final int id;
  final String industryName;

  Industry({
    required this.id,
    required this.industryName,
  });

  factory Industry.fromJson(Map<String, dynamic> json) {
    return Industry(
      id: json['id'],
      industryName: json['industry_name'],
    );
  }
}
