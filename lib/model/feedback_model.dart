class FeedBackModel {
  int? id;
  String? body;
  int? rating;
  String? feedbackedAt;
  Student? student;

  FeedBackModel(
      {this.id, this.body, this.rating, this.feedbackedAt, this.student});

  FeedBackModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    rating = json['rating'];
    feedbackedAt = json['feedbacked_at'];
    student =
        json['student'] != null ? new Student.fromJson(json['student']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['rating'] = this.rating;
    data['feedbacked_at'] = this.feedbackedAt;
    if (this.student != null) {
      data['student'] = this.student!.toJson();
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
