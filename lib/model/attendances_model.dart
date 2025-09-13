class AttendancesModel {
  int? id;
  Lecture? lecture;
  String? status;
  String? notes;

  AttendancesModel({this.id, this.lecture, this.status, this.notes});

  AttendancesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lecture =
        json['lecture'] != null ? new Lecture.fromJson(json['lecture']) : null;
    status = json['status'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.lecture != null) {
      data['lecture'] = this.lecture!.toJson();
    }
    data['status'] = this.status;
    data['notes'] = this.notes;
    return data;
  }
}

class Lecture {
  int? id;
  String? name;

  Lecture({this.id, this.name});

  Lecture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
