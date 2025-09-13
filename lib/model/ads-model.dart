class AdsModel {
  int? id;
  String? media;
  String? type;

  AdsModel({this.id, this.media, this.type});

  AdsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    media = json['media'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['media'] = this.media;
    data['type'] = this.type;
    return data;
  }
}
