class ReceiptDetailsModel {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? type;
  String? name;
  int? transactionId;
  int? amount;
  String? date;
  String? status;

  ReceiptDetailsModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.type,
      this.name,
      this.transactionId,
      this.amount,
      this.date,
      this.status});

  ReceiptDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    type = json['type'];
    name = json['name'];
    transactionId = json['transaction_id'];
    amount = json['amount'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['name'] = this.name;
    data['transaction_id'] = this.transactionId;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}
