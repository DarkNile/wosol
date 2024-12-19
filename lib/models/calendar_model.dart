class CalendarModel {
  String? status;
  List<CalendarData>? data;

  CalendarModel({this.status, this.data});

  CalendarModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CalendarData>[];
      json['data'].forEach((v) {
        data!.add(CalendarData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CalendarData {
  String? date;
  String? startTime;
  String? endTime;
  List<SubData>? subData;


  CalendarData({this.date, this.startTime, this.endTime, this.subData});

  CalendarData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    if (json['sub_data'] != null) {
      subData = <SubData>[];
      json['sub_data'].forEach((v) {
        subData!.add(SubData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    if (subData != null) {
      data['sub_data'] = subData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubData {
  String? calendarId;
  String? orderId;
  bool? isOldDate;
  String? userId;
  String? firstName;
  String? lastName;
  String? date;
  String? time;
  String? cancelRequest;
  String? cancelReason;
  String? tripRound;
  String? cancelDate;
  String? from;
  String? universityName;
  String? gateName;
  String? fromLat;
  String? fromLng;
  String? toLat;
  String? toLng;

  SubData(
      {this.calendarId,
      this.orderId,
      this.userId,
      this.firstName,
      this.lastName,
      this.date,
      this.time,
      this.cancelRequest,
      this.cancelReason,
      this.tripRound,
      this.cancelDate,
      this.from,
      this.universityName,
      this.gateName,
      this.fromLat,
      this.fromLng,
      this.toLat,
      this.toLng});

  SubData.fromJson(Map<String, dynamic> json) {
    calendarId = json['calendar_id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    isOldDate = json['old_date'] ?? false;
    lastName = json['last_name'];
    date = json['date'];
    time = json['time'];
    cancelRequest = json['cancel_request'];
    cancelReason = json['cancel_reason'];
    tripRound = json['trip_round'];
    cancelDate = json['cancel_date'];
    from = json['From'];
    universityName = json['university_name'];
    gateName = json['gate_name'];
    fromLat = json['from_lat'];
    fromLng = json['from_lng'];
    toLat = json['to_lat'];
    toLng = json['to_lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['calendar_id'] = calendarId;
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['date'] = date;
    data['time'] = time;
    data['cancel_request'] = cancelRequest;
    data['cancel_reason'] = cancelReason;
    data['trip_round'] = tripRound;
    data['cancel_date'] = cancelDate;
    data['From'] = from;
    data['university_name'] = universityName;
    data['gate_name'] = gateName;
    data['from_lat'] = fromLat;
    data['from_lng'] = fromLng;
    data['to_lat'] = toLat;
    data['to_lng'] = toLng;
    return data;
  }
}
