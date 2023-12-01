class AllMembersResponse {
  List<AllMembersData>? data;

  AllMembersResponse({this.data});

  AllMembersResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllMembersData>[];
      json['data'].forEach((v) {
        data!.add(  AllMembersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllMembersData {
  int? userId;
  String? userFirstname;
  String? userLastname;
  String? userAvatar;

  AllMembersData({this.userId, this.userFirstname, this.userLastname, this.userAvatar});

  AllMembersData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userFirstname = json['user_firstname'];
    userLastname = json['user_lastname'];
    userAvatar = json['user_avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_firstname'] = userFirstname;
    data['user_lastname'] = userLastname;
    data['user_avatar'] = userAvatar;
    return data;
  }
}