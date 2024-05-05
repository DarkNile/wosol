class StudentRoutes {
  final List<TripData> data;

  StudentRoutes({required this.data});

  factory StudentRoutes.fromJson(Map<String, dynamic> json) {
    List<dynamic> dataList = json['data'];
    List<TripData> trips = dataList.map((data) => TripData.fromJson(data)).toList();
    return StudentRoutes(data: trips);
  }
}

class TripData {
  final String date;
  final String startTime;
  final String endTime;
  final List<SubData> subData;

  TripData({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.subData,
  });

  factory TripData.fromJson(Map<String, dynamic> json) {
    List<dynamic> subDataList = json['sub_data'];
    List<SubData> subData = subDataList.map((data) => SubData.fromJson(data)).toList();
    return TripData(
      date: json['date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      subData: subData,
    );
  }
}

class SubData {
  final String tripId;
  final String userId;
  final String userType;
  final String tourismType;
  final String userFname;
  final String userLname;
  final String tripDate;
  final String tripTime;
  final String tripRound;
  final String driverName;
  final String driverPhone;
  final String plateNumber;
  final String cancelRequest;
  final String cancelReason;
  final String cancelDate;
  final String address;
  final String from;
  final String to;
  final String universityName;
  final String gateName;
  final String pickupLat;
  final String pickupLong;
  final String dropLat;
  final String dropLong;
  final String tripStatus;
  final String tripStart;
  final String tripEnd;
  final String carModel;
  final String carSeats;

  SubData({
    required this.tripId,
    required this.userId,
    required this.userType,
    required this.tourismType,
    required this.userFname,
    required this.userLname,
    required this.tripDate,
    required this.tripTime,
    required this.tripRound,
    required this.driverName,
    required this.driverPhone,
    required this.plateNumber,
    required this.cancelRequest,
    required this.cancelReason,
    required this.cancelDate,
    required this.address,
    required this.from,
    required this.to,
    required this.universityName,
    required this.gateName,
    required this.pickupLat,
    required this.pickupLong,
    required this.dropLat,
    required this.dropLong,
    required this.tripStatus,
    required this.tripStart,
    required this.tripEnd,
    required this.carModel,
    required this.carSeats,
  });

  factory SubData.fromJson(Map<String, dynamic> json) {
    return SubData(
      tripId: json['trip_id'],
      userId: json['user_id'],
      userType: json['user_type'],
      tourismType: json['tourism_type'],
      userFname: json['user_fname'],
      userLname: json['user_lname'],
      tripDate: json['trip_date'],
      tripTime: json['trip_time'],
      tripRound: json['trip_round'],
      driverName: json['driver_name'],
      driverPhone: json['driver_phone'],
      plateNumber: json['plate_number'],
      cancelRequest: json['cancel_request'],
      cancelReason: json['cancel_reason'],
      cancelDate: json['cancel_date'],
      address: json['address'],
      from: json['From'],
      to: json['To'],
      universityName: json['university_name'],
      gateName: json['gate_name'],
      pickupLat: json['pickup_lat'],
      pickupLong: json['pickup_long'],
      dropLat: json['drop_lat'],
      dropLong: json['drop_long'],
      tripStatus: json['trip_status'],
      tripStart: json['trip_start'],
      tripEnd: json['trip_end'],
      carModel: json['car_model'],
      carSeats: json['car_seats'],
    );
  }
}
