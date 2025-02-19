class CancelReasonsModel {
  final String status;
  final List<CancelReasons> data;

  CancelReasonsModel({required this.status, required this.data});

  factory CancelReasonsModel.fromJson(Map<String, dynamic> json) =>
      CancelReasonsModel(
        status: json['status'] as String,
        data: List<CancelReasons>.from(
          json['data'].map((x) => CancelReasons.fromJson(x)),
        ),
      );
}


class CancelReasons {
  String? reasonId;
  String? reasonAr;
  String? reasonEn;

  CancelReasons({this.reasonId, this.reasonAr, this.reasonEn});

  CancelReasons.fromJson(Map<String, dynamic> json) {
    reasonId = json['reason_id'];
    reasonAr = json['reason_ar'];
    reasonEn = json['reason_en'];
  }
}