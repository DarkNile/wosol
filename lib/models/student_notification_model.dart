class StudentNotification {
  String nId;
  String osType;
  String toType;
  String type;
  String requestId;
  String userId;
  String driverId;
  String vehicleId;
  String tripId;
  String title;
  String text;
  String read;
  String dateAdded;
  String modifiedDate;
  NotificationTrip? trip;

  StudentNotification({
    required this.nId,
    required this.osType,
    required this.toType,
    required this.type,
    required this.requestId,
    required this.userId,
    required this.driverId,
    required this.vehicleId,
    required this.tripId,
    required this.title,
    required this.text,
    required this.read,
    required this.dateAdded,
    required this.modifiedDate,
    required this.trip,
  });

  factory StudentNotification.fromJson(Map<String, dynamic> json) {
    return StudentNotification(
      nId: json['n_id'] ?? "",
      osType: json['os_type'] ?? "",
      toType: json['to_type'] ?? "",
      type: json['type'] ?? "",
      requestId: json['request_id'] ?? "",
      userId: json['user_id'] ?? "",
      driverId: json['driver_id'] ?? "",
      vehicleId: json['vehicle_id'] ?? "",
      tripId: json['trip_id'] ?? "",
      title: json['title'] ?? "",
      text: json['text'] ?? "",
      read: json['read'] ?? "",
      dateAdded: json['date_added'] ?? "",
      modifiedDate: json['modified_date'] ?? "",
      trip: json['trip_data'] == null || json['trip_data'].isEmpty
          ? null
          : NotificationTrip.fromJson(json['trip_data']),
    );
  }
}

class NotificationTrip {
  NotificationTrip({
    required this.tripId,
    required this.tripType,
    required this.tourismType,
    required this.driverName,
    required this.vehicleId,
    required this.vehiclePlate,
    required this.fromPlace,
    required this.toPlace,
    required this.fromTitle,
    required this.toTitle,
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

  String tripId;
  String tripType;
  String tourismType;
  String driverName;
  String vehicleId;
  String vehiclePlate;
  String fromPlace;
  String toPlace;
  String fromTitle;
  String toTitle;
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

  factory NotificationTrip.fromJson(Map<String, dynamic> json) =>
      NotificationTrip(
        tripId: json["trip_id"] ?? "",
        tripType: json["trip_type"] ?? "",
        tourismType: json["tourism_type"] ?? "",
        driverName: json["driver_name"] ?? "",
        vehicleId: json["vehicle_id"] ?? "",
        vehiclePlate: json["vehicle_plate"] ?? "",
        fromPlace: json["from"] ?? "",
        toPlace: json["to"] ?? "",
        fromTitle: json['address'] ?? "",
        toTitle: json['university_name'] ?? "",
        tripDate: json["trip_date"] ?? "",
        tripTime: json["trip_time"] ?? "",
        tripRound: json["trip_round"] ?? "",
        tripStatus: json["trip_status"] ?? "",
        tripStart: json["trip_start"] ?? "",
        tripEnd: json["trip_end"] ?? "",
        fromLat: json["from_lat"] ?? "",
        fromLong: json["from_long"] ?? "",
        toLat: json["to_lat"] ?? "",
        toLong: json["to_long"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "trip_type": tripType,
        "tourism_type": tourismType,
        "driver_name": driverName,
        "vehicle_id": vehicleId,
        "vehicle_plate": vehiclePlate,
        "from": fromPlace,
        "to": toPlace,
        "address": fromTitle,
        "university_name": toTitle,
        "trip_date": tripDate,
        "trip_time": tripTime,
        "trip_round": tripRound,
        "trip_status": tripStatus,
        "trip_start": tripStart,
        "trip_end": tripEnd,
        "from_lat": fromLat,
        "from_long": fromLong,
        "to_lat": toLat,
        "to_long": toLong,
      };
}
