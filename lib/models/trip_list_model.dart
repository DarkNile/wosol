
List<Trip> tripFromJson(Map<String, dynamic> json) =>
    List<Trip>.from(json["data"].map((x) => Trip.fromJson(x)));

Map<String, dynamic> tripToJson(List<Trip> data) => {
  "data": List<dynamic>.from(data.map((x) => x.toJson())),
};
class Trip {
  Trip({
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
    required this.companyName,
    required this.companyTelephone,
    required this.companyEmail,
    required this.tripIsRunning,
    required this.isReachStart,
    required this.students,
  });

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
  String companyName;
  String companyTelephone;
  String companyEmail;
  bool tripIsRunning;
  bool isReachStart;
  List<Student> students;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        tripId: json["trip_id"] ?? "",
        tripType: json["trip_type"] ?? "",
        tourismType: json["tourism_type"] ?? "",
        driverName: json["driver_name"] ?? "",
        vehicleId: json["vehicle_id"] ?? "",
        vehiclePlate: json["vehicle_plate"] ?? "",
        from: json["from"] ?? "",
        to: json["to"] ?? "",
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
        companyName: json["company_name"] ?? "",
        companyTelephone: json["company_telephone"] ?? "",
        companyEmail: json["company_email"] ?? "",
        tripIsRunning: json['is_trip_run']?? false,
        isReachStart: json['is_reach_start']?? false,
        students: List<Student>.from(
            json["students"].map((x) => Student.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "trip_id": tripId,
        "trip_type": tripType,
        "tourism_type": tourismType,
        "driver_name": driverName,
        "vehicle_id": vehicleId,
        "vehicle_plate": vehiclePlate,
        "from": from,
        "to": to,
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
        "company_name": companyName,
        "company_telephone": companyTelephone,
        "company_email": companyEmail,
        "is_trip_run": tripIsRunning,
        "is_reach_start": isReachStart,
        "students": List<dynamic>.from(students.map((x) => x.toJson())),
      };
}

class Student {
  Student({
    required this.tripUserId,
    required this.userId,
    required this.userFname,
    required this.userLname,
    required this.attendance,
    required this.cancelRequest,
    required this.cancelReason,
    required this.userEmail,
    required this.gender,
    required this.address,
    required this.userZone,
    required this.userCity,
    required this.userDistrict,
    required this.pickupLat,
    required this.pickupLong,
  });

  String tripUserId;
  String userId;
  String userFname;
  String userLname;
  String attendance;
  String cancelRequest;
  String cancelReason;
  String userEmail;
  String gender;
  String address;
  String userZone;
  String userCity;
  String userDistrict;
  String pickupLat;
  String pickupLong;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        tripUserId: json["trip_user_id"] ?? "",
        userId: json["user_id"] ?? "",
        userFname: json["user_fname"] ?? "",
        userLname: json["user_lname"] ?? "",
        attendance: json["attendance"] ?? "",
        cancelRequest: json["cancel_request"] ?? "",
        cancelReason: json["cancel_reason"] ?? "",
        userEmail: json["user_email"] ?? "",
        gender: json["gender"] ?? "",
        address: json["address"] ?? "",
        userZone: json["user_zone"] ?? "",
        userCity: json["user_city"] ?? "",
        userDistrict: json["user_district"] ?? "",
        pickupLat: json["pickup_lat"] ?? "",
        pickupLong: json["pickup_long"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "trip_user_id": tripUserId,
        "user_id": userId,
        "user_fname": userFname,
        "user_lname": userLname,
        "attendance": attendance,
        "cancel_request": cancelRequest,
        "cancel_reason": cancelReason,
        "user_email": userEmail,
        "gender": gender,
        "address": address,
        "user_zone": userZone,
        "user_city": userCity,
        "user_district": userDistrict,
        "pickup_lat": pickupLat,
        "pickup_long": pickupLong,
      };
}
