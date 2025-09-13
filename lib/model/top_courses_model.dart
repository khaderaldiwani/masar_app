class TopCoursesModel {
  int? id;
  bool? is_favorited;
  String? name;
  String? image;
  int? rating;
  int? numberOfStudents;
  String? categoryName;
  bool? is_enrolled;
  Teacher? teacher;

  TopCoursesModel(
      {this.id,
      this.is_favorited,
      this.is_enrolled,
      this.name,
      this.image,
      this.rating,
      this.numberOfStudents,
      this.categoryName,
      this.teacher});

  TopCoursesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    is_favorited = json['is_favorited'];
    is_enrolled = json['is_enrolled'];
    name = json['name'];
    image = json['image'];
    rating = json['rating'];
    numberOfStudents = json['number_of_students'];
    categoryName = json['category_name'];
    teacher =
        json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_favorited'] = this.is_favorited;
    data['is_enrolled'] = this.is_enrolled;
    data['name'] = this.name;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['number_of_students'] = this.numberOfStudents;
    data['category_name'] = this.categoryName;
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
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
