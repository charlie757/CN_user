class CountryModel {
  dynamic id;
  dynamic title;

  CountryModel({this.id, this.title});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = title;
    return data;
  }
}
