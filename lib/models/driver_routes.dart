class DriverRoute {
  String tripId;
  String tripType;
  String tourismType;
  String driverName;
  String vehicleId;
  String vehiclePlate;
  String from;
  String to;
  String tripDate;
  String tripTime;
  String tripRound;
  String tripStatus;
  String tripStart;
  String tripEnd;
  String fromLat;
  String fromLong;
  String toLat;
  String toLong;

  DriverRoute({
    required this.tripId,
    required this.tripType,
    required this.tourismType,
    required this.driverName,
    required this.vehicleId,
    required this.vehiclePlate,
    required this.from,
    required this.to,
    required this.tripDate,
    required this.tripTime,
    required this.tripRound,
    required this.tripStatus,
    required this.tripStart,
    required this.tripEnd,
    required this.fromLat,
    required this.fromLong,
    required this.toLat,
    required this.toLong,
  });

  factory DriverRoute.fromJson(Map<String, dynamic> json) {
    return DriverRoute(
      tripId: json['trip_id'] ?? "",
      tripType: json['trip_type']?? "",
      tourismType: json['tourism_type']?? "",
      driverName: json['driver_name']?? "",
      vehicleId: json['vehicle_id']?? "",
      vehiclePlate: json['vehicle_plate']?? "",
      from: json['from']?? "",
      to: json['to']?? "",
      tripDate: json['trip_date']?? "",
      tripTime: json['trip_time']?? "",
      tripRound: json['trip_round']?? "",
      tripStatus: json['trip_status']?? "",
      tripStart: json['trip_start']?? "",
      tripEnd: json['trip_end']?? "",
      fromLat: json['from_lat']?? "",
      fromLong: json['from_long']?? "",
      toLat: json['to_lat']?? "",
      toLong: json['to_long']?? "",
    );
  }
}
