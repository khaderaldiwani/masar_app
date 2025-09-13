class AssessmentsModel {
  int? id;
  String? title;
  String? type;
  String? date;
  String? maxScore;
  List<Grades>? grades;

  AssessmentsModel(
      {this.id, this.title, this.type, this.date, this.maxScore, this.grades});

  AssessmentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    date = json['date'];
    maxScore = json['max_score'];
    if (json['grades'] != null) {
      grades = <Grades>[];
      json['grades'].forEach((v) {
        grades!.add(new Grades.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['date'] = this.date;
    data['max_score'] = this.maxScore;
    if (this.grades != null) {
      data['grades'] = this.grades!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Grades {
  int? id;
  Student? student;
  int? score;
  String? notes;

  Grades({this.id, this.student, this.score, this.notes});

  Grades.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    student =
        json['student'] != null ? new Student.fromJson(json['student']) : null;
    score = json['score'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.student != null) {
      data['student'] = this.student!.toJson();
    }
    data['score'] = this.score;
    data['notes'] = this.notes;
    return data;
  }
}

class Student {
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;

  Student({this.id, this.firstName, this.middleName, this.lastName});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    return data;
  }
}
