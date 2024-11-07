// industry_model.dart

class Location {
  final int id;
  final String location_name;

 Location({
    required this.id,
    required this.location_name,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      location_name: json['location_name'],
    );
  }
}


// industry_model.dart

