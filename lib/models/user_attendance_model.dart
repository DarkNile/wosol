class UserAttendanceModel {
  String? tripId;
  String? userId;
  String? tripUserId;
  bool? attendance;
  String? userType;
  String? userFName;
  String? userLName;
  String? tripDate;
  String? tripTime;
  String? driverName;
  String? plateNumber;
  String? from;
  String? universityName;
  String? gateName;
  String? tripStatus;
  String? tripStart;
  String? tripEnd;
  String? carModel;

  UserAttendanceModel(
      {this.tripId,
      this.userId,
      this.tripUserId,
      this.attendance,
      this.userType,
      this.userFName,
      this.userLName,
      this.tripDate,
      this.tripTime,
      this.driverName,
      this.plateNumber,
      this.from,
      this.universityName,
      this.gateName,
      this.tripStatus,
      this.tripStart,
      this.tripEnd,
      this.carModel});

  UserAttendanceModel.fromJson(Map<String, dynamic> json) {
    tripId = json['trip_id'];
    userId = json['user_id'];
    tripUserId = json['trip_user_id'];
    attendance = json['attendance'];
    userType = json['user_type'];
    userFName = json['user_fname'];
    userLName = json['user_lname'];
    tripDate = json['trip_date'];
    tripTime = json['trip_time'];
    driverName = json['driver_name'];
    plateNumber = json['plate_number'];
    from = json['From'];
    universityName = json['university_name'];
    gateName = json['gate_name'];
    tripStatus = json['trip_status'];
    tripStart = json['trip_start'];
    tripEnd = json['trip_end'];
    carModel = json['car_model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trip_id'] = tripId;
    data['user_id'] = userId;
    data['trip_user_id'] = tripUserId;
    data['attendance'] = attendance;
    data['user_type'] = userType;
    data['user_fname'] = userFName;
    data['user_lname'] = userLName;
    data['trip_date'] = tripDate;
    data['trip_time'] = tripTime;
    data['driver_name'] = driverName;
    data['plate_number'] = plateNumber;
    data['From'] = from;
    data['university_name'] = universityName;
    data['gate_name'] = gateName;
    data['trip_status'] = tripStatus;
    data['trip_start'] = tripStart;
    data['trip_end'] = tripEnd;
    data['car_model'] = carModel;
    return data;
  }
}
