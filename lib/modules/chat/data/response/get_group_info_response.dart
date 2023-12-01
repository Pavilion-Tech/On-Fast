class GroupInfoResponse {
  GroupInfoData? data;

  GroupInfoResponse({this.data});

  GroupInfoResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? GroupInfoData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GroupInfoData {
  int? chatRoomId;
  ChatRoomCreator? chatRoomCreator;
  List<ChatRoomUsers>? chatRoomUsers;
  String? chatRoomType;
  String? chatRoomName;
  String? chatRoomImage;
  String? chatRoomTimestamp;

  GroupInfoData(
      {this.chatRoomId,
        this.chatRoomCreator,
        this.chatRoomUsers,
        this.chatRoomType,
        this.chatRoomName,
        this.chatRoomImage,
        this.chatRoomTimestamp});

  GroupInfoData.fromJson(Map<String, dynamic> json) {
    chatRoomId = json['chat_room_id'];
    chatRoomCreator = json['chat_room_creator'] != null
        ? ChatRoomCreator.fromJson(json['chat_room_creator'])
        : null;
    if (json['chat_room_users'] != null) {
      chatRoomUsers = <ChatRoomUsers>[];
      json['chat_room_users'].forEach((v) {
        chatRoomUsers!.add(ChatRoomUsers.fromJson(v));
      });
    }
    chatRoomType = json['chat_room_type'];
    chatRoomName = json['chat_room_name'];
    chatRoomImage = json['chat_room_image'];
    chatRoomTimestamp = json['chat_room_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_room_id'] = chatRoomId;
    if (chatRoomCreator != null) {
      data['chat_room_creator'] = chatRoomCreator!.toJson();
    }

    data['chat_room_type'] = chatRoomType;
    data['chat_room_name'] = chatRoomName;
    data['chat_room_image'] = chatRoomImage;
    data['chat_room_timestamp'] = chatRoomTimestamp;
    return data;
  }
}

class ChatRoomCreator {
  int? userId;
  String? userFirstname;
  String? userLastname;
  String? userAvatar;

  ChatRoomCreator(
      {this.userId, this.userFirstname, this.userLastname, this.userAvatar});

  ChatRoomCreator.fromJson(Map<String, dynamic> json) {
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
class ChatRoomUsers {
  int? userId;
  String? userFirstname;
  String? userLastname;
  String? userAvatar;

  ChatRoomUsers(
      {this.userId, this.userFirstname, this.userLastname, this.userAvatar});

  ChatRoomUsers.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userFirstname = json['user_firstname'];
    userLastname = json['user_lastname'];
    userAvatar = json['user_avatar'];
  }


}