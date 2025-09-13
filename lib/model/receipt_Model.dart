class ReceiptModel {
  int? id;
  String? name;
  int? amount;
  String? status;

  ReceiptModel({this.id, this.name, this.amount, this.status});

  ReceiptModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['status'] = this.status;
    return data;
  }
}
