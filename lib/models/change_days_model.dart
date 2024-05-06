class ChangeDaysModel {
  final String dayId;
  final String orderId;
  final String dayName;
  final String time1;
  final String time2;
  String? requestChange;
  String? isOn;

  ChangeDaysModel(
      {required this.dayId,
      required this.orderId,
      required this.dayName,
      required this.time1,
      required this.time2,
      this.requestChange,
      this.isOn});

  factory ChangeDaysModel.fromJson(Map<String, dynamic> json) {
    return ChangeDaysModel(
      dayId: json['day_id'],
      orderId: json['order_id'],
      dayName: json['day_name'],
      time1: json['time_1'],
      time2: json['time_2'],
      requestChange: json['request_change'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day_id': dayId,
      'order_id': orderId,
      'time_1': time1,
      'time_2': time2,
      "is_on": isOn,
    };
  }
}
