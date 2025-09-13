class TopTeachersModel {
  int? id;
  String? firstName;
  String? lastName;
  String? image;

  TopTeachersModel({this.id, this.firstName, this.lastName, this.image});

  TopTeachersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    return data;
  }
}
