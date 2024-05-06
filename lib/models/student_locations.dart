class StudentLocation {
  final String? homeAddress;
  final double? homeLatitude;
  final double? homeLongitude;
  final String? universityName;
  final String? universityGate;
  final double? universityLatitude;
  final double? universityLongitude;

  StudentLocation({
    this.homeAddress,
    this.homeLatitude,
    this.homeLongitude,
    this.universityName,
    this.universityGate,
    this.universityLatitude,
    this.universityLongitude,
  });

  factory StudentLocation.fromJson(Map<String, dynamic> json) {
    final homeData = json['data']['Home'];
    final universityData = json['data']['university'];

    return StudentLocation(
      homeAddress: homeData is Map ? homeData['address'] : null,
      homeLatitude: homeData is Map ? double.tryParse(homeData['lat']) : null,
      homeLongitude: homeData is Map ? double.tryParse(homeData['long']) : null,
      universityName: universityData is Map ? universityData['university_name'] : null,
      universityGate: universityData is Map ? universityData['university_gate'] : null,
      universityLatitude: universityData is Map ? double.tryParse(universityData['lat']) : null,
      universityLongitude: universityData is Map ? double.tryParse(universityData['long']) : null,
    );
  }
}

