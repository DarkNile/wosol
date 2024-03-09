class DriverModel {
  String status;
  DriverData data;

  DriverModel({required this.status, required this.data});

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      status: json['status'] ?? "",
      data: DriverData.fromJson(json['data']),
    );
  }
}

class DriverData {
  String driverId;
  String firstName;
  String lastName;
  String telephone;
  String userEmail;
  String userName;
  String password;
  String birthDate;
  String idNo;
  String idEndDate;
  String licenseType;
  String licenseEndDate;
  String licenseCity;
  String vehicles;
  String active;
  String lastLogin;
  String userAgent;
  String loginType;
  String token;

  DriverData({
    required this.driverId,
    required this.firstName,
    required this.lastName,
    required this.telephone,
    required this.userEmail,
    required this.userName,
    required this.password,
    required this.birthDate,
    required this.idNo,
    required this.idEndDate,
    required this.licenseType,
    required this.licenseEndDate,
    required this.licenseCity,
    required this.vehicles,
    required this.active,
    required this.lastLogin,
    required this.userAgent,
    required this.loginType,
    required this.token,
  });

  factory DriverData.fromJson(Map<String, dynamic> json) {
    return DriverData(
      driverId: json['driver_id'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      telephone: json['telephone'] ?? "",
      userEmail: json['user_email'] ?? "",
      userName: json['user_name'] ?? "",
      password: json['password'] ?? "",
      birthDate: json['birth_date'] ?? "",
      idNo: json['id_no'] ?? "",
      idEndDate: json['id_end_date'] ?? "",
      licenseType: json['license_type'] ?? "",
      licenseEndDate: json['license_end_date'] ?? "",
      licenseCity: json['license_city'] ?? "",
      vehicles: json['vehicles'] ?? "",
      active: json['active'] ?? "",
      lastLogin: json['last_login'] ?? "",
      userAgent: json['user_agent'] ?? "",
      loginType: json['login_type'] ?? "",
      token: json['token'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driver_id': driverId,
      'first_name': firstName,
      'last_name': lastName,
      'telephone': telephone,
      'user_email': userEmail,
      'user_name': userName,
      'password': password,
      'birth_date': birthDate,
      'id_no': idNo,
      'id_end_date': idEndDate,
      'license_type': licenseType,
      'license_end_date': licenseEndDate,
      'license_city': licenseCity,
      'vehicles': vehicles,
      'active': active,
      'last_login': lastLogin,
      'user_agent': userAgent,
      'login_type': loginType,
      'token': token,
    };
  }
}
