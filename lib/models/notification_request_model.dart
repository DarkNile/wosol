List<NotificationRequestModel> notificationFromJson(Map<String, dynamic> json) =>
    List<NotificationRequestModel>.from(json["data"].map((x) => NotificationRequestModel.fromJson(x)));

class NotificationRequestModel {
  String requestId;
  String employeeName;
  String employeePhone;
  String employeeEmail;
  String groupId;
  String orderId;
  String userId;
  String mapLat;
  String mapLong;
  String requestStatus;
  String tripId;
  String driverId;
  String vehicleId;
  String dateAdded;

  NotificationRequestModel({
    required this.requestId,
    required this.employeeName,
    required this.employeePhone,
    required this.employeeEmail,
    required this.groupId,
    required this.orderId,
    required this.userId,
    required this.mapLat,
    required this.mapLong,
    required this.requestStatus,
    required this.tripId,
    required this.driverId,
    required this.vehicleId,
    required this.dateAdded,
  });

  factory NotificationRequestModel.empty() {
    return NotificationRequestModel(
      requestId: "",
      employeeName: "",
      employeePhone: "",
      employeeEmail: "",
      groupId: "",
      orderId: "",
      userId: "",
      mapLat: "",
      mapLong: "",
      requestStatus: "",
      tripId: "",
      driverId: "",
      vehicleId: "",
      dateAdded: "",
    );
  }

  factory NotificationRequestModel.fromJson(Map<String, dynamic> json) {
    return NotificationRequestModel(
      requestId: json['request_id'] ?? "",
      employeeName: json['employee_name'] ?? "",
      employeePhone: json['employee_phone'] ?? "",
      employeeEmail: json['employee_email'] ?? "",
      groupId: json['group_id'] ?? "",
      orderId: json['order_id'] ?? "",
      userId: json['user_id'] ?? "",
      mapLat: json['map_lat'] ?? "",
      mapLong: json['map_long'] ?? "",
      requestStatus: json['request_status'] ?? "",
      tripId: json['trip_id'] ?? "",
      driverId: json['driver_id'] ?? "",
      vehicleId: json['vehicle_id'] ?? "",
      dateAdded: json['date_added'] ?? "",
    );
  }
}
