class StudentProfileModel {
  int? id;
  String? username;
  String? firstName;
  String? middleName;
  String? lastName;
  String? phone;
  String? parentPhone;
  String? image;
  String? educationLevel;
  String? gender;
  String? birthDate;
  int? completedCoursesCount;
  int? feedbacksCount;
  int? answersCount;
  int? feedbacksAvg;

  StudentProfileModel(
      {this.id,
      this.username,
      this.firstName,
      this.middleName,
      this.lastName,
      this.phone,
      this.parentPhone,
      this.image,
      this.educationLevel,
      this.gender,
      this.birthDate,
      this.completedCoursesCount,
      this.feedbacksCount,
      this.answersCount,
      this.feedbacksAvg});

  StudentProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    parentPhone = json['parent_phone'];
    image = json['image'];
    educationLevel = json['education_level'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    completedCoursesCount = json['completed_courses_count'];
    feedbacksCount = json['feedbacks_count'];
    answersCount = json['answers_count'];
    feedbacksAvg = json['feedbacks_avg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['parent_phone'] = this.parentPhone;
    data['image'] = this.image;
    data['education_level'] = this.educationLevel;
    data['gender'] = this.gender;
    data['birth_date'] = this.birthDate;
    data['completed_courses_count'] = this.completedCoursesCount;
    data['feedbacks_count'] = this.feedbacksCount;
    data['answers_count'] = this.answersCount;
    data['feedbacks_avg'] = this.feedbacksAvg;
    return data;
  }
}
