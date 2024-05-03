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
    );
  }
}
