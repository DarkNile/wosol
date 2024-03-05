class TripDriverModel {
  String? tripUserId;
  String? userId;
  String? userFname;
  String? userLname;
  String? attendance;
  String? cancelRequest;
  String? cancelReason;
  String? userEmail;
  String? gender;
  String? address;
  String? userZone;
  String? userCity;
  String? userDistrict;
  String? pickupLat;
  String? pickupLong;

  TripDriverModel(
      {this.tripUserId,
      this.userId,
      this.userFname,
      this.userLname,
      this.attendance,
      this.cancelRequest,
      this.cancelReason,
      this.userEmail,
      this.gender,
      this.address,
      this.userZone,
      this.userCity,
      this.userDistrict,
      this.pickupLat,
      this.pickupLong});

  TripDriverModel.fromJson(Map<String, dynamic> json) {
    tripUserId = json['trip_user_id'];
    userId = json['user_id'];
    userFname = json['user_fname'];
    userLname = json['user_lname'];
    attendance = json['attendance'];
    cancelRequest = json['cancel_request'];
    cancelReason = json['cancel_reason'];
    userEmail = json['user_email'];
    gender = json['gender'];
    address = json['address'];
    userZone = json['user_zone'];
    userCity = json['user_city'];
    userDistrict = json['user_district'];
    pickupLat = json['pickup_lat'];
    pickupLong = json['pickup_long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trip_user_id'] = tripUserId;
    data['user_id'] = userId;
    data['user_fname'] = userFname;
    data['user_lname'] = userLname;
    data['attendance'] = attendance;
    data['cancel_request'] = cancelRequest;
    data['cancel_reason'] = cancelReason;
    data['user_email'] = userEmail;
    data['gender'] = gender;
    data['address'] = address;
    data['user_zone'] = userZone;
    data['user_city'] = userCity;
    data['user_district'] = userDistrict;
    data['pickup_lat'] = pickupLat;
    data['pickup_long'] = pickupLong;
    return data;
  }
}
