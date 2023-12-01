 import '../../presentation/cubit/chat_msg_cubit/chat_msg_cubit.dart';
import '../model/chat_messages_model.dart';
import 'chat_room_response.dart';

class SendMessageResponse {
  SendMsgData? data;

  SendMessageResponse({this.data});

  SendMessageResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? SendMsgData.fromJson(json['data']) : null;
  }

}
class SendMsgData {
  int? chatId;
  int? chatFrom;
  List<int>? chatTo;
  String? chatMessage;
  String? time;
  String? chatMessageType;
  String? chatAttachment;
  int? userId;
  int? unseenCount;
  String? userFirstname;
  String? userLastname;
  String? userAvatar;
  int? chatFavorite;

  SendMsgData(
      {this.chatId,
        this.chatFrom,
        this.chatTo,
        this.chatMessage,
        this.time,
        this.chatMessageType,
        this.chatAttachment,
        this.userId,
        this.unseenCount,
        this.userFirstname,
        this.userLastname,
        this.userAvatar,
        this.chatFavorite});

  SendMsgData.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    chatFrom = json['chat_from'];
    chatTo = json['chat_to'].cast<int>();
    chatMessage = json['chat_message'];
    time = json['time'];
    unseenCount  = json['unseen_count'];
    chatMessageType = json['chat_message_type'];
    chatAttachment = json['chat_attachment'];
    userId = json['user_id'];
    userFirstname = json['user_firstname'];
    userLastname = json['user_lastname'];
    userAvatar = json['user_avatar'];
    chatFavorite = json['chat_favorite'];
  }


}

extension ChatMessagesModelExtension on   SendMsgData? {
  ChatMessagesModel toChatMessagesModel() {

    return ChatMessagesModel(
      time: this?.time??"",
      state:   MsgState.success ,
      userId: this?.userId??-1,
      userName: this?.userFirstname??"",
      chatMessageType: this?.chatMessageType??"",
      chatFrom: this?.chatFrom??-1,
      chatFavorite: this?.chatFavorite??0,
      chatAttachment: this?.chatAttachment??"",
      chatId: this?.chatId??-1,
      chatMessage: this?.chatMessage??"",
      // chatTo: this?.chatTo??-1,
    );
  }
}