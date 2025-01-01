class ContactDataModel {
  String? contactPhone;
  String? contactEmail;

  ContactDataModel({this.contactPhone, this.contactEmail});

  ContactDataModel.fromJson(Map<String, dynamic> json) {
    contactPhone = json['contact_phone'];
    contactEmail = json['contact_email'];
  }
}
