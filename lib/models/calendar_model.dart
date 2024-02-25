class CalendarModel {
  String status;
  List<CalendarData> data;

  CalendarModel({required this.status, required this.data});

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      status: json['status'],
      data: (json['data'] as List)
          .map((item) => CalendarData.fromJson(item))
          .toList(),
    );
  }
}

class CalendarData {
  String date;
  List<SubData> subData;

  CalendarData({required this.date, required this.subData});

  factory CalendarData.fromJson(Map<String, dynamic> json) {
    return CalendarData(
      date: json['date'],
      subData: (json['sub_data'] as List)
          .map((item) => SubData.fromJson(item))
          .toList(),
    );
  }
}

class SubData {
  String calendarId;
  String orderId;
  String userId;
  String firstName;
  String lastName;
  String date;
  String time;
  String cancelRequest;
  String cancelReason;
  String cancelDate;
  String from;
  String universityName;
  String gateName;
  String fromLat;
  String fromLng;
  String toLat;
  String toLng;

  SubData({
    required this.calendarId,
    required this.orderId,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.date,
    required this.time,
    required this.cancelRequest,
    required this.cancelReason,
    required this.cancelDate,
    required this.from,
    required this.universityName,
    required this.gateName,
    required this.fromLat,
    required this.fromLng,
    required this.toLat,
    required this.toLng,
  });

  factory SubData.fromJson(Map<String, dynamic> json) {
    return SubData(
      calendarId: json['calendar_id'] ?? "",
      orderId: json['order_id'] ?? "",
      userId: json['user_id'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      date: json['date'] ?? "",
      time: json['time'] ?? "",
      cancelRequest: json['cancel_request'] ?? "0",
      cancelReason: json['cancel_reason'] ?? "",
      cancelDate: json['cancel_date'] ?? "",
      from: json['From'] ?? "",
      universityName: json['university_name'] ?? "",
      gateName: json['gate_name'] ?? "",
      fromLat: json['from_lat'] ?? "",
      fromLng: json['from_lng'] ?? "",
      toLat: json['to_lat'] ?? "",
      toLng: json['to_lng'] ?? "",
    );
  }
}
