class TeacherProfileModel {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? phone;
  String? image;
  String? educationLevel;
  String? specialization;
  String? headline;
  String? experiences;
  String? description;
  int? rate;
  String? joinDate;
  int? coursesCount;
  int? studentsCount;
  int? feedbacksCount;

  TeacherProfileModel(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.phone,
      this.image,
      this.educationLevel,
      this.specialization,
      this.headline,
      this.experiences,
      this.description,
      this.rate,
      this.joinDate,
      this.coursesCount,
      this.studentsCount,
      this.feedbacksCount});

  TeacherProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    image = json['image'];
    educationLevel = json['education_level'];
    specialization = json['specialization'];
    headline = json['headline'];
    experiences = json['experiences'];
    description = json['description'];
    rate = json['rate'];
    joinDate = json['join_date'];
    coursesCount = json['courses_count'];
    studentsCount = json['students_count'];
    feedbacksCount = json['feedbacks_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['education_level'] = this.educationLevel;
    data['specialization'] = this.specialization;
    data['headline'] = this.headline;
    data['experiences'] = this.experiences;
    data['description'] = this.description;
    data['rate'] = this.rate;
    data['join_date'] = this.joinDate;
    data['courses_count'] = this.coursesCount;
    data['students_count'] = this.studentsCount;
    data['feedbacks_count'] = this.feedbacksCount;
    return data;
  }
}
