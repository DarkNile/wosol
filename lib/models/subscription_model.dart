class SubscriptionModel {
  String? id;
  String? price;
  String? startDate;
  String? endDate;
  String? tripType;
  String? from;
  String? to;
  String? remainingDays;


  SubscriptionModel(
      {this.id,
        this.price,
        this.startDate,
        this.endDate,
        this.tripType,
        this.from,
        this.to,
        this.remainingDays,
        });

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['order_id']??'';
    price = json['price_total']??'';
    startDate = json['date_start']??'';
    endDate = json['date_end']??'';
    tripType = json['trip_round']??'';
    from = json['from']??'';
    to = json['to']??'';
    remainingDays = json['remaining_days']??'';
  }
}
