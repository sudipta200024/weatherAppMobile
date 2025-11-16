// models/location_model.dart

class LocationModel {
  final Location location;

  LocationModel({required this.location});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      location: Location.fromJson(json['location']),
    );
  }
}

class Location {
  final String name;
  final String region;
  final String country;

  Location({
    required this.name,
    required this.region,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] as String,
      region: json['region'] as String,
      country: json['country'] as String,
    );
  }
}