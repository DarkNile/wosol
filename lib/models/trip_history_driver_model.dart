class TripHistoryDriverModel {
  String? tripId;
  String? tripType;
  String? tourismType;
  String? driverName;
  String? vehicleId;
  String? vehiclePlate;
  String? universityName;
  String? tripDate;
  String? tripTime;
  String? tripRound;
  String? tripStatus;
  String? tripStart;
  String? tripEnd;

  TripHistoryDriverModel(
      {this.tripId,
      this.tripType,
      this.tourismType,
      this.driverName,
      this.vehicleId,
      this.vehiclePlate,
      this.universityName,
      this.tripDate,
      this.tripTime,
      this.tripRound,
      this.tripStatus,
      this.tripStart,
      this.tripEnd});

  TripHistoryDriverModel.fromJson(Map<String, dynamic> json) {
    tripId = json['trip_id'];
    tripType = json['trip_type'];
    tourismType = json['tourism_type'];
    driverName = json['driver_name'];
    vehicleId = json['vehicle_id'];
    vehiclePlate = json['vehicle_plate'];
    universityName = json['university_name'];
    tripDate = json['trip_date'];
    tripTime = json['trip_time'];
    tripRound = json['trip_round'];
    tripStatus = json['trip_status'];
    tripStart = json['trip_start'];
    tripEnd = json['trip_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trip_id'] = tripId;
    data['trip_type'] = tripType;
    data['tourism_type'] = tourismType;
    data['driver_name'] = driverName;
    data['vehicle_id'] = vehicleId;
    data['vehicle_plate'] = vehiclePlate;
    data['university_name'] = universityName;
    data['trip_date'] = tripDate;
    data['trip_time'] = tripTime;
    data['trip_round'] = tripRound;
    data['trip_status'] = tripStatus;
    data['trip_start'] = tripStart;
    data['trip_end'] = tripEnd;
    return data;
  }
}
