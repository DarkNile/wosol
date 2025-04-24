class NotificationModel {
  String? nId;
  String? osType;
  String? toType;
  String? type;
  String? requestId;
  String? userId;
  String? driverId;
  String? vehicleId;
  String? tripId;
  String? title;
  String? textAr;
  String? textEn;
  String? read;
  String? dateAdded;
  String? modifiedDate;

  NotificationModel(
      {this.nId,
      this.osType,
      this.toType,
      this.type,
      this.requestId,
      this.userId,
      this.driverId,
      this.vehicleId,
      this.tripId,
      this.title,
      this.textAr,
      this.textEn,
      this.read,
      this.dateAdded,
      this.modifiedDate});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    nId = json['n_id'];
    osType = json['os_type'];
    toType = json['to_type'];
    type = json['type'];
    requestId = json['request_id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    vehicleId = json['vehicle_id'];
    tripId = json['trip_id'];
    title = json['title'];
    textAr = json['text_ar'];
    textEn = json['text_en'];
    read = json['read'];
    dateAdded = json['date_added'];
    modifiedDate = json['modified_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['n_id'] = nId;
    data['os_type'] = osType;
    data['to_type'] = toType;
    data['type'] = type;
    data['request_id'] = requestId;
    data['user_id'] = userId;
    data['driver_id'] = driverId;
    data['vehicle_id'] = vehicleId;
    data['trip_id'] = tripId;
    data['title'] = title;
    data['text_ar'] = textAr;
    data['text_en'] = textEn;
    data['read'] = read;
    data['date_added'] = dateAdded;
    data['modified_date'] = modifiedDate;
    return data;
  }
}
