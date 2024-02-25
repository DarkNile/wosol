class TripInfoUserModel {
  String? tripUserId;
  String? userId;
  String? tripId;
  String? attendance;
  String? attendanceDate;
  String? cancelRequest;
  String? cancelDate;
  String? cancelReason;

  TripInfoUserModel(
      {this.tripUserId,
      this.userId,
      this.tripId,
      this.attendance,
      this.attendanceDate,
      this.cancelRequest,
      this.cancelDate,
      this.cancelReason});

  TripInfoUserModel.fromJson(Map<String, dynamic> json) {
    tripUserId = json['trip_user_id'];
    userId = json['user_id'];
    tripId = json['trip_id'];
    attendance = json['attendance'];
    attendanceDate = json['attendance_date'];
    cancelRequest = json['cancel_request'];
    cancelDate = json['cancel_date'];
    cancelReason = json['cancel_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trip_user_id'] = tripUserId;
    data['user_id'] = userId;
    data['trip_id'] = tripId;
    data['attendance'] = attendance;
    data['attendance_date'] = attendanceDate;
    data['cancel_request'] = cancelRequest;
    data['cancel_date'] = cancelDate;
    data['cancel_reason'] = cancelReason;
    return data;
  }
}
