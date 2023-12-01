class AddGroupOrDeleteGroupMemberResponse {
  String? data;

  AddGroupOrDeleteGroupMemberResponse({this.data});

  AddGroupOrDeleteGroupMemberResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    return data;
  }
}