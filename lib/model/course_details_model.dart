class CourseDetailsModel {
  int? id;
  String? name;
  String? description;
  String? image;
  int? price;
  String? level;
  int? rating;
  int? numberOfStudents;
  String? categoryName;
  bool? isEnrolled;
  bool? isFinished;
  String? startDate;
  String? endDate;
  int? numberOfHours;
  int? feedbacksCount;
  int? feedbacksAvgRating;
  Teacher? teacher;
  Discount? discount;
  int? finalPrice;
  bool?  is_favorited;
  CourseDetailsModel(
      {this.id,
      this.is_favorited,
      this.name,
      this.description,
      this.image,
      this.price,
      this.level,
      this.rating,
      this.numberOfStudents,
      this.categoryName,
      this.isEnrolled,
      this.isFinished,
      this.startDate,
      this.endDate,
      this.numberOfHours,
      this.feedbacksCount,
      this.feedbacksAvgRating,
      this.teacher,
      this.discount,
      this.finalPrice});

  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    is_favorited=json['is_favorited'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    level = json['level'];
    rating = json['rating'];
    numberOfStudents = json['number_of_students'];
    categoryName = json['category_name'];
    isEnrolled = json['is_enrolled'];
    isFinished = json['is_finished'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    numberOfHours = json['number_of_hours'];
    feedbacksCount = json['feedbacks_count'];
    feedbacksAvgRating = json['feedbacks_avg_rating'];
    teacher =
        json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
    discount = json['discount'] != null
        ? new Discount.fromJson(json['discount'])
        : null;
    finalPrice = json['final_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_favorited']=this.is_favorited;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['level'] = this.level;
    data['rating'] = this.rating;
    data['number_of_students'] = this.numberOfStudents;
    data['category_name'] = this.categoryName;
    data['is_enrolled'] = this.isEnrolled;
    data['is_finished'] = this.isFinished;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['number_of_hours'] = this.numberOfHours;
    data['feedbacks_count'] = this.feedbacksCount;
    data['feedbacks_avg_rating'] = this.feedbacksAvgRating;
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    if (this.discount != null) {
      data['discount'] = this.discount!.toJson();
    }
    data['final_price'] = this.finalPrice;
    return data;
  }
}

class Teacher {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  String? headline;

  Teacher({this.id, this.firstName, this.lastName, this.image, this.headline});

  Teacher.fromJson(Map<String, dynamic> json) {
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

class Discount {
  int? id;
  String? type;
  String? value;
  int? discountableId;
  String? discountableType;
  String? expirationDate;

  Discount(
      {this.id,
      this.type,
      this.value,
      this.discountableId,
      this.discountableType,
      this.expirationDate});

  Discount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
    discountableId = json['discountable_id'];
    discountableType = json['discountable_type'];
    expirationDate = json['expiration_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['value'] = this.value;
    data['discountable_id'] = this.discountableId;
    data['discountable_type'] = this.discountableType;
    data['expiration_date'] = this.expirationDate;
    return data;
  }
}
