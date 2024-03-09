class UserModel {
  String status;
  UserData data;

  UserModel({required this.status, required this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'] ?? "",
      data: UserData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
    };
  }
}

class UserData {
  String userId;
  String userType;
  String userFname;
  String userLname;
  String companyName;
  String userEmail;
  String userPass;
  String telephone;
  String supervisorId;
  String userNationality;
  String nationalId;
  String gender;
  String address;
  String userZone;
  String userCity;
  String userDistrict;
  String parentName;
  String parentType;
  String parntNationalId;
  String parentPhone;
  String parentEmail;
  String dateAdded;
  String lastLogin;
  String userAgent;
  String loginType;
  String token;

  UserData({
    required this.userId,
    required this.userType,
    required this.userFname,
    required this.userLname,
    required this.companyName,
    required this.userEmail,
    required this.userPass,
    required this.telephone,
    required this.supervisorId,
    required this.userNationality,
    required this.nationalId,
    required this.gender,
    required this.address,
    required this.userZone,
    required this.userCity,
    required this.userDistrict,
    required this.parentName,
    required this.parentType,
    required this.parntNationalId,
    required this.parentPhone,
    required this.parentEmail,
    required this.dateAdded,
    required this.lastLogin,
    required this.userAgent,
    required this.loginType,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['user_id'] ?? "",
      userType: json['user_type'] ?? "",
      userFname: json['user_fname'] ?? "",
      userLname: json['user_lname'] ?? "",
      companyName: json['company_name'] ?? "",
      userEmail: json['user_email'] ?? "",
      userPass: json['user_pass'] ?? "",
      telephone: json['telephone'] ?? "",
      supervisorId: json['supervisor_id'] ?? "",
      userNationality: json['user_nationality'] ?? "",
      nationalId: json['national_id'] ?? "",
      gender: json['gender'] ?? "",
      address: json['address'] ?? "",
      userZone: json['user_zone'] ?? "",
      userCity: json['user_city'] ?? "",
      userDistrict: json['user_district'] ?? "",
      parentName: json['parent_name'] ?? "",
      parentType: json['parent_type'] ?? "",
      parntNationalId: json['parnt_national_id'] ?? "",
      parentPhone: json['parent_phone'] ?? "",
      parentEmail: json['parent_email'] ?? "",
      dateAdded: json['date_added'] ?? "",
      lastLogin: json['last_login'] ?? "",
      userAgent: json['user_agent'] ?? "",
      loginType: json['login_type'] ?? "",
      token: json['token'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_type': userType,
      'user_fname': userFname,
      'user_lname': userLname,
      'company_name': companyName,
      'user_email': userEmail,
      'user_pass': userPass,
      'telephone': telephone,
      'supervisor_id': supervisorId,
      'user_nationality': userNationality,
      'national_id': nationalId,
      'gender': gender,
      'address': address,
      'user_zone': userZone,
      'user_city': userCity,
      'user_district': userDistrict,
      'parent_name': parentName,
      'parent_type': parentType,
      'parnt_national_id': parntNationalId,
      'parent_phone': parentPhone,
      'parent_email': parentEmail,
      'date_added': dateAdded,
      'last_login': lastLogin,
      'user_agent': userAgent,
      'login_type': loginType,
      'token': token,
    };
  }
}
