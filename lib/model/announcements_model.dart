class AnnouncementsModel {
  int? id;
  Teacher? teacher;
  String? body;
  String? datetime;

  AnnouncementsModel({this.id, this.teacher, this.body, this.datetime});

  AnnouncementsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacher =
        json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
    body = json['body'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    data['body'] = this.body;
    data['datetime'] = this.datetime;
    return data;
  }
}

class Teacher {
  int? id;
  String? firstName;
  String? lastName;
  String? image;

  Teacher({this.id, this.firstName, this.lastName, this.image});

  Teacher.fromJson(Map<String, dynamic> json) {
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
