class VehicleModel {
  String? vehicleId;
  String? plateNumber;
  String? vinNumber;
  String? model;
  String? seats;
  String? km;

  VehicleModel(
      {this.vehicleId,
      this.plateNumber,
      this.vinNumber,
      this.model,
      this.seats,
      this.km});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicle_id'];
    plateNumber = json['plate_number'];
    vinNumber = json['vin_number'];
    model = json['model'];
    seats = json['seats'];
    km = json['km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicle_id'] = vehicleId;
    data['plate_number'] = plateNumber;
    data['vin_number'] = vinNumber;
    data['model'] = model;
    data['seats'] = seats;
    data['km'] = km;
    return data;
  }
}
