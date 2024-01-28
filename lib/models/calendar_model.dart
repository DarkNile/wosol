class CalendarModel {
  String status;
  List<CalendarData> data;

  CalendarModel({required this.status, required this.data});

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      status: json['status'],
      data: (json['data'] as List<dynamic>)
          .map((item) => CalendarData.fromJson(item))
          .toList(),
    );
  }
}

class CalendarData {
  String calendarId;
  String orderId;
  String userId;
  String userType;
  String date;
  String time;
  String tripRound;
  String cancelRequest;
  String doneTripAdd;

  CalendarData({
    required this.calendarId,
    required this.orderId,
    required this.userId,
    required this.userType,
    required this.date,
    required this.time,
    required this.tripRound,
    required this.cancelRequest,
    required this.doneTripAdd,
  });

  factory CalendarData.fromJson(Map<String, dynamic> json) {
    return CalendarData(
      calendarId: json['calendar_id'] ?? "",
      orderId: json['order_id'] ?? "",
      userId: json['user_id'] ?? "",
      userType: json['user_type'] ?? "",
      date: json['date'] ?? "",
      time: json['time'] ?? "",
      tripRound: json['trip_round'] ?? "",
      cancelRequest: json['cancel_request'] ?? "",
      doneTripAdd: json['done_trip_add'] ?? "",
    );
  }
}
