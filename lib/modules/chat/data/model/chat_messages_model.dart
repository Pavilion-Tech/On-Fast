
import '../../presentation/cubit/chat_msg_cubit/chat_msg_cubit.dart';

class ChatMessagesModel {

  bool? isMine;
  int? messageType;
  String? sender;
  String? message;
  String? uploadedMessageFile;
  String? date;
  MsgState state = MsgState.success;

  ChatMessagesModel(
      {
         this.uploadedMessageFile,
         this.date,
         this.message,
         this.sender,
         this.isMine,
         this.messageType,
        this.state = MsgState.success ,
         });
}

 
