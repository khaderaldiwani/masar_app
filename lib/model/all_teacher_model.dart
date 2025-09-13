class AllTeacherModel {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  String? headline;

  AllTeacherModel(
      {this.id, this.firstName, this.lastName, this.image, this.headline});

  AllTeacherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    headline = json['headline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['image'] = this.image;
    data['headline'] = this.headline;
    return data;
  }
}
