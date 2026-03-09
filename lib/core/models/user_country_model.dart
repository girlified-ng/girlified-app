class UserCountryModel {
  String? name;
  String? flagEmoji;
  String? dialCode;
  UserCountryModel({this.flagEmoji, this.dialCode, this.name});

  UserCountryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    flagEmoji = json['flagEmoji'];
    dialCode = json['dialCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['flagEmoji'] = this.flagEmoji;
    data['dialCode'] = this.dialCode;
    return data;
  }
}
