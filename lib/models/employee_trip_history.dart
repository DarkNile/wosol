class EmployeeTrip {
  final String tripId;
  final String tripType;
  final String coType;
  final String tourismType;
  final String driverName;
  final String vehicleId;
  final String vehiclePlate;
  final String universityName;
  final String companyName;
  final String companyTelephone;
  final String companyEmail;
  final String from;
  final String to;
  final String tripDate;
  final String tripTime;
  final String tripTimeEnd;
  final String tripRound;
  final String tripStatus;
  final String tripStart;
  final String tripEnd;
  final double fromLat;
  final double fromLong;
  final double toLat;
  final double toLong;

  EmployeeTrip({
    required this.tripId,
    required this.tripType,
    required this.coType,
    required this.tourismType,
    required this.driverName,
    required this.vehicleId,
    required this.vehiclePlate,
    required this.universityName,
    required this.companyName,
    required this.companyTelephone,
    required this.companyEmail,
    required this.from,
    required this.to,
    required this.tripDate,
    required this.tripTime,
    required this.tripTimeEnd,
    required this.tripRound,
    required this.tripStatus,
    required this.tripStart,
    required this.tripEnd,
    required this.fromLat,
    required this.fromLong,
    required this.toLat,
    required this.toLong,
  });

  factory EmployeeTrip.fromJson(Map<String, dynamic> json) => EmployeeTrip(
        tripId: json['trip_id'] as String,
        tripType: json['trip_type'] as String,
        coType: json['co_type'] as String,
        tourismType: json['tourism_type'] as String,
        driverName: json['driver_name'] as String,
        vehicleId: json['vehicle_id'] as String,
        vehiclePlate: json['vehicle_plate'] as String,
        universityName: json['university_name'] as String,
        companyName: json['company_name'] as String,
        companyTelephone: json['company_telephone'] as String,
        companyEmail: json['company_email'] as String,
        from: json['from'] as String,
        to: json['to'] as String,
        tripDate: json['trip_date'] as String,
        tripTime: json['trip_time'] as String,
        tripTimeEnd: json['trip_time_end'] as String,
        tripRound: json['trip_round'] as String,
        tripStatus: json['trip_status'] as String,
        tripStart: json['trip_start'] as String,
        tripEnd: json['trip_end'] as String,
        fromLat: double.parse(json['from_lat'] as String),
        fromLong: double.parse(json['from_long'] as String),
        toLat: double.parse(json['to_lat'] as String),
        toLong: double.parse(json['to_long'] as String),
      );
}

class EmployeeTripHistory {
  final String status;
  final List<EmployeeTrip> data;

  EmployeeTripHistory({required this.status, required this.data});

  factory EmployeeTripHistory.fromJson(Map<String, dynamic> json) =>
      EmployeeTripHistory(
        status: json['status'] as String,
        data: List<EmployeeTrip>.from(
          json['data'].map((x) => EmployeeTrip.fromJson(x)),
        ),
      );
}
