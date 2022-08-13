class CountryModel {
  String? name;
  String? code;
  String? emoji;
  String? unicode;
  String? image;

  CountryModel({this.name, this.code, this.emoji, this.unicode, this.image});

  CountryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    emoji = json['emoji'];
    unicode = json['unicode'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['emoji'] = this.emoji;
    data['unicode'] = this.unicode;
    data['image'] = this.image;
    return data;
  }
}
