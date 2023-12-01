
import '../../presentation/cubit/chat_msg_cubit/chat_msg_cubit.dart';

class ChatMessagesModel {

  int chatId;
  int chatFrom;
  int? chatTo;
  String chatMessage;
  int? chatRoomId;
  String time;
  String chatMessageType;
  String userName;
  int  userId;
  String chatAttachment;
  int chatFavorite;
  MsgState state = MsgState.success;

  ChatMessagesModel(
      {
      required  this.chatId,
        this.state = MsgState.success ,
        required this.chatFrom,
         this.chatTo,
         this.chatRoomId,
        required this.time,
        required this.userId,
        required this.userName,
        required this.chatMessage,
        required this.chatAttachment,
        required this.chatMessageType,
        required this.chatFavorite});
}

 
