class ReportReasonsModel {
  final String status;
  final List<ReportReasons> data;

  ReportReasonsModel({required this.status, required this.data});

  factory ReportReasonsModel.fromJson(Map<String, dynamic> json) =>
      ReportReasonsModel(
        status: json['status'] as String,
        data: List<ReportReasons>.from(
          json['data'].map((x) => ReportReasons.fromJson(x)),
        ),
      );
}


class ReportReasons {
  String? reportId;
  String? reportAr;
  String? reportEn;

  ReportReasons({this.reportId, this.reportAr, this.reportEn});

  ReportReasons.fromJson(Map<String, dynamic> json) {
    reportId = json['report_data_id'];
    reportAr = json['report_ar'];
    reportEn = json['report_en'];
  }
}