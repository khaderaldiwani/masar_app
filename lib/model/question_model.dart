class QuestionModel {
  int? id;
  Student? student;
  String? body;
  String? askedAt;
  List<Answers>? answers;

  QuestionModel({this.id, this.student, this.body, this.askedAt, this.answers});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    student =
        json['student'] != null ? new Student.fromJson(json['student']) : null;
    body = json['body'];
    askedAt = json['asked_at'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.student != null) {
      data['student'] = this.student!.toJson();
    }
    data['body'] = this.body;
    data['asked_at'] = this.askedAt;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Student {
  int? id;
  String? firstName;
  String? lastName;
  String? image;

  Student({this.id, this.firstName, this.lastName, this.image});

  Student.fromJson(Map<String, dynamic> json) {
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

class Answers {
  int? id;
  Student? user;
  String? body;
  String? answeredAt;
  bool? isApproved;

  Answers({this.id, this.user, this.body, this.answeredAt, this.isApproved});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new Student.fromJson(json['user']) : null;
    body = json['body'];
    answeredAt = json['answered_at'];
    isApproved = json['is_approved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['body'] = this.body;
    data['answered_at'] = this.answeredAt;
    data['is_approved'] = this.isApproved;
    return data;
  }
}
