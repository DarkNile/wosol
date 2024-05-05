class SubscriptionModel {
  String? id;
  String? price;
  String? startDate;
  String? endDate;
  String? tripType;
  String? from;
  String? to;


  SubscriptionModel(
      {this.id,
        this.price,
        this.startDate,
        this.endDate,
        this.tripType,
        this.from,
        this.to,
        });

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    tripType = json['trip_type'];
    from = json['from'];
    to = json['to'];
  }
}
