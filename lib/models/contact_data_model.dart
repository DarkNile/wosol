class ContactDataModel {
  String? contactPhone;
  String? contactEmail;
  String? contactWhatsapp;

  ContactDataModel({this.contactPhone, this.contactEmail, this.contactWhatsapp});

  ContactDataModel.fromJson(Map<String, dynamic> json) {
    contactPhone = json['contact_phone'];
    contactEmail = json['contact_email'];
    contactWhatsapp = json['contact_whatsapp'];
  }
}
