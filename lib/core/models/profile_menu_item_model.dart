class ProfileMenuItemModel {
  String? icon;
  String? title;
  String? route_to;

  ProfileMenuItemModel({this.icon, this.title, this.route_to});

  ProfileMenuItemModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    route_to = json['route_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['route_to'] = this.route_to;
    return data;
  }
}
