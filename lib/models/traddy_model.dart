List<TraddyModel> traddyTripsFromJson(Map<String, dynamic> json) =>
    List<TraddyModel>.from(json["data"].map((x) => TraddyModel.fromJson(x)));

Map<String, dynamic> traddyTripsToJson(List<TraddyModel> data) => {
  "data": List<dynamic>.from(data.map((x) => x.toJson())),
};


class TraddyModel {
  String requestId;
  String memberId;
  String employeeName;
  String employeePhone;
  String employeeEmail;
  String groupId;
  String orderId;
  String userId;
  String lat;
  String lng;
  String requestStatus;
  String tripId;
  String driverId;
  String vehicleId;
  String dateAdded;
  String driverReach;
  String driverReachDate;


  TraddyModel({
    required this.requestId,
    required this.memberId,
    required this.employeeName,
    required this.employeePhone,
    required this.employeeEmail,
    required this.groupId,
    required this.orderId,
    required this.userId,
    required this.lat,
    required this.lng,
    required this.requestStatus,
    required this.tripId,
    required this.driverId,
    required this.vehicleId,
    required this.dateAdded,
    required this.driverReach,
    required this.driverReachDate,

  });

  factory TraddyModel.fromJson(Map<String, dynamic> json) {
    return TraddyModel(
      requestId: json['request_id']?? "",
      memberId: json['member_id'] ?? "",
      employeeName: json['employee_name'] ?? "",
      employeePhone: json['employee_phone'] ?? "",
      employeeEmail: json['employee_email'] ?? "",
      groupId: json['group_id'] ?? "",
      orderId: json['order_id'] ?? "",
      userId: json['user_id'] ?? "",
      lat: json['lat'] ?? "",
      lng: json['lng'] ?? "",
      requestStatus: json['request_status'] ?? "",
      tripId: json['trip_id'] ?? "",
      driverId: json['driver_id'] ?? "",
      vehicleId: json['vehicle_id'] ?? "",
      dateAdded: json['date_added'] ?? "",
      driverReach: json['driver_reach'] ?? "",
      driverReachDate: json['driver_reach_date'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'member_id': memberId,
      'employee_name': employeeName,
      'employee_phone': employeePhone,
      'employee_email': employeeEmail,
      'group_id': groupId,
      'order_id': orderId,
      'user_id': userId,
      'lat': lat,
      'lng': lng,
      'request_status': requestStatus,
      'trip_id': tripId,
      'driver_id': driverId,
      'vehicle_id': vehicleId,
      'date_added': dateAdded,
      'driver_reach': driverReach,
      'driver_reach_date': driverReachDate,
    };
  }
}
