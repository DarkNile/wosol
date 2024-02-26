class TripModel {
  String? date;
  String? startTime;
  String? endTime;
  List<SubData>? subData;

  TripModel({this.date, this.startTime, this.endTime, this.subData});

  TripModel.fromJson(Map<String, dynamic> json) {
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
  String? tripId;
  String? userId;
  String? userType;
  String? tourismType;
  String? userFname;
  String? userLname;
  String? tripDate;
  String? tripTime;
  String? tripRound;
  String? driverName;
  String? driverPhone;
  String? plateNumber;
  String? cancelRequest;
  String? cancelReason;
  String? cancelDate;
  String? from;
  String? universityName;
  String? gateName;
  String? pickupLat;
  String? pickupLong;
  String? dropLat;
  String? dropLong;
  String? tripStatus;
  String? tripStart;
  String? tripEnd;
  String? carModel;
  String? carSeats;

  SubData(
      {this.tripId,
      this.userId,
      this.userType,
      this.tourismType,
      this.userFname,
      this.userLname,
      this.tripDate,
      this.tripTime,
      this.tripRound,
      this.driverName,
      this.driverPhone,
      this.plateNumber,
      this.cancelRequest,
      this.cancelReason,
      this.cancelDate,
      this.from,
      this.universityName,
      this.gateName,
      this.pickupLat,
      this.pickupLong,
      this.dropLat,
      this.dropLong,
      this.tripStatus,
      this.tripStart,
      this.tripEnd,
      this.carModel,
      this.carSeats});

  SubData.fromJson(Map<String, dynamic> json) {
    tripId = json['trip_id'];
    userId = json['user_id'];
    userType = json['user_type'];
    tourismType = json['tourism_type'];
    userFname = json['user_fname'];
    userLname = json['user_lname'];
    tripDate = json['trip_date'];
    tripTime = json['trip_time'];
    tripRound = json['trip_round'];
    driverName = json['driver_name'];
    driverPhone = json['driver_phone'];
    plateNumber = json['plate_number'];
    cancelRequest = json['cancel_request'];
    cancelReason = json['cancel_reason'];
    cancelDate = json['cancel_date'];
    from = json['From'];
    universityName = json['university_name'];
    gateName = json['gate_name'];
    pickupLat = json['pickup_lat'];
    pickupLong = json['pickup_long'];
    dropLat = json['drop_lat'];
    dropLong = json['drop_long'];
    tripStatus = json['trip_status'];
    tripStart = json['trip_start'];
    tripEnd = json['trip_end'];
    carModel = json['car_model'];
    carSeats = json['car_seats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trip_id'] = tripId;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['tourism_type'] = tourismType;
    data['user_fname'] = userFname;
    data['user_lname'] = userLname;
    data['trip_date'] = tripDate;
    data['trip_time'] = tripTime;
    data['trip_round'] = tripRound;
    data['driver_name'] = driverName;
    data['driver_phone'] = driverPhone;
    data['plate_number'] = plateNumber;
    data['cancel_request'] = cancelRequest;
    data['cancel_reason'] = cancelReason;
    data['cancel_date'] = cancelDate;
    data['From'] = from;
    data['university_name'] = universityName;
    data['gate_name'] = gateName;
    data['pickup_lat'] = pickupLat;
    data['pickup_long'] = pickupLong;
    data['drop_lat'] = dropLat;
    data['drop_long'] = dropLong;
    data['trip_status'] = tripStatus;
    data['trip_start'] = tripStart;
    data['trip_end'] = tripEnd;
    data['car_model'] = carModel;
    data['car_seats'] = carSeats;
    return data;
  }
}
