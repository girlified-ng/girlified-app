class OnboardingItemModel {
  String? title1;
  String? title2;
  String? title3;
  String? image;
  String? description;

  OnboardingItemModel(
      {this.title1, this.title2, this.title3, this.image, this.description});

  OnboardingItemModel.fromJson(Map<String, dynamic> json) {
    title1 = json['title1'];
    title2 = json['title2'];
    title3 = json['title3'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title1'] = this.title1;
    data['title2'] = this.title2;
    data['title3'] = this.title3;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}
