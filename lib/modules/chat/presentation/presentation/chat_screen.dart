import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:on_fast/modules/chat/presentation/presentation/widget/chat_messages_body/just_text.dart';
import 'package:on_fast/modules/chat/presentation/presentation/widget/chat_messages_body/normal_image.dart';
import 'package:on_fast/modules/chat/presentation/presentation/widget/chat_messages_body/voice_widget.dart';
import 'package:on_fast/modules/chat/presentation/presentation/widget/custom_send_message.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/shimmer/notification_shimmer.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constant.dart';
import '../../../../shared/components/uti.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../widgets/chat/record_item.dart';
import '../../../../widgets/item_shared/default_appbar.dart';
import '../../../../widgets/item_shared/image_net.dart';
import '../../../../widgets/item_shared/image_screen.dart';
import '../../data/model/chat_messages_model.dart';
import '../../data/response/chat_room_response.dart';
import '../cubit/chat_msg_cubit/chat_msg_cubit.dart';
import '../cubit/chat_msg_cubit/chat_msg_state.dart';

enum Type{text,image,record}
class ChatScreen extends StatefulWidget {


  const ChatScreen({
    super.key,

  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ChatMsgCubit.get(context).messages.clear();
    ChatMsgCubit.get(context).getChatMsg(id: "65698998f4d6af4c9721f7ed");


  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: InkWell(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        child: BlocConsumer<ChatMsgCubit, ChatMsgState>(
          listener: (context, state) {},
          builder: (context, state) {
            var chatMsgCubit = ChatMsgCubit.get(context);
            if (chatMsgCubit.messages.isEmpty && state is ChatMsgLoadState) {
              return NotificationShimmer();
              // return Center(child: UTI.loadingWidget(),);
            }
            if (chatMsgCubit.messages.isEmpty && state is ChatMsgSuccessState) {
              return UTI.dataEmptyWidget(noData: tr("noDataFounded"), imageName: Images.productNotFound);
              // return UTI.dataEmptyWidget(noData: LocaleKeys.noDataFounded.tr(), imageName: ImgAssets.productNotFound);
            }
            if (state is ChatMsgErrorState) {
              return UTI.dataEmptyWidget(noData:  tr("noDataFounded"), imageName:Images.productNotFound);
            }
            return Container(

              child: Column(children: [
                DefaultAppBar( "",color: Colors.white),
                Expanded(
                  child: buildListView(chatMsgCubit),
                ),
                const SizedBox(
                  height: 65,
                ),
                CustomSendMessages( ),
              ]),
            );
          },
        ),
      ),

    );
  }





  Widget buildListView(ChatMsgCubit chatMsgCubit) {
    return SingleChildScrollView(
      child: ListView.builder(
          reverse: true,
          shrinkWrap: true,
          controller: chatMsgCubit.controllerScroll,
          cacheExtent: 500,
          addRepaintBoundaries: false,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          itemCount: chatMsgCubit.messages.length,
          itemBuilder: (_, int i) {
          return  ChatItem(
              type: chatMsgCubit.messages[i].messageType == 1 ?Type.text:chatMsgCubit.messages[i].messageType == 2?Type.image:Type.record,
              content: chatMsgCubit.messages[i].messageType == 1?chatMsgCubit.messages[i].message??'':chatMsgCubit.messages[i].uploadedMessageFile??'',
              createdAt:  chatMsgCubit.messages[i].date??'',
              isUser: chatMsgCubit.messages[i].sender == 'user'?true:false,
            );
          }),
    );
  }

  _chatMsgItem(
      SupportChat message,
    bool isMe,
  ) {
    return Column(
        crossAxisAlignment:isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
      // if (message.chatMessageType == "voice" && message.chatAttachment.isSoundUrl())
      //   // ///انا عدلت على الباكدج دي خليت لون ال loading يكون grey سواء في me او receiver لان الباكدج كانت دايما بتجيب لون ال loading في me مش مظبوط
      //   voiceWidget(isMe, message)
      // else if (message.chatMessageType == "image")
      //   BubbleNormalImageUpdate(
      //     caption: message.chatMessage,
      //     id: message.chatId.toString(),
      //     userName: message.userName,
      //     image: message.chatAttachment.contains('https')
      //         ? CachedNetworkImage(
      //             imageUrl: message.chatAttachment,
      //             progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
      //                 height: 150,
      //                 child: Center(
      //                     child: CircularProgressIndicator(
      //                   value: downloadProgress.progress,
      //                   color: Colors.white,
      //                 ))),
      //             errorWidget: (context, url, error) => const Icon(Icons.error),
      //           )
      //         : Image.file(
      //             File(message.chatAttachment),
      //             fit: BoxFit.cover,
      //           ),
      //     isMe: isMe,
      //   )
      //
      //
      // else if (message.chatMessageType == "text")
        MessageJustText(isMe: isMe, message: message.message??"", ),
      // timeAndCheckMessageStatus(isMe, message),
    ]);
  }

  Container voiceWidget(bool isMe, ChatMessagesModel message) {
    print("voiceWidget ${message.chatAttachment}");
    return Container(alignment: isMe ? Alignment.topRight : Alignment.topLeft, child: Column(
      children: [

        VoiceWidget(audio: message.chatAttachment, isMe: isMe,userName: message.userName),
      ],
    )

        );
  }

  Widget timeAndCheckMessageStatus(bool isMe, ChatMessagesModel message) {
    return Row(mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start, children: [
      Text(message.time ?? "", style: const TextStyle(fontSize: 10, color: Colors.grey)),
      const SizedBox(width: 5),
      message.state.toWidget(),
      // const Spacer(),

    ]);
  }
}

extension MsgStateEx on MsgState {
  toWidget() {
    switch (this) {
      case MsgState.success:
        return   Icon(Icons.done_all, size: 15, color:  defaultColor);
      case MsgState.error:
        return const Icon(Icons.error_outline, size: 15, color: Colors.redAccent);
      case MsgState.loading:
        return const Icon(Icons.watch_later_outlined, size: 15, color: Colors.grey);
    }
  }
}

extension StringFormat on String? {
  bool isSoundUrl() {
    List<String> l = ["mp3", "m4a", "wav", "aac"];
    String e = (this ?? "").split(".").last;
    return l.contains(e);
  }
}
class ChatItem extends StatelessWidget {
  ChatItem({
    required this.isUser,
    required this.type,
    required this.content,
    required this.createdAt,
  });


  bool isUser;
  Type type;
  String content;
  String createdAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          end: isUser?0:30,start: isUser?30:0
      ),
      child: Column(
        crossAxisAlignment: isUser?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(
            createdAt,
            style: TextStyle(
                color: Colors.grey.shade500,fontSize: 11
            ),
          ),
          Builder(builder: (BuildContext context) {
            switch(type){
              case Type.text:
                return
                  Container(
                      decoration: BoxDecoration(
                        color: isUser?defaultColor:HexColor('#EEEEEE'),
                        borderRadius: BorderRadiusDirectional.only(
                          topStart:Radius.circular(isUser?20:0),
                          topEnd: Radius.circular(isUser?0:20),
                          bottomEnd: const Radius.circular(20),
                          bottomStart:const  Radius.circular(20),
                        ),
                      ),
                      padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                      child:Text(
                        content,
                        textAlign: isUser?TextAlign.end:TextAlign.start,
                        style: TextStyle(
                            color: isUser?Colors.white:null,fontSize: 11
                        ),
                      )
                  );
              case Type.image:
                return InkWell(
                  onTap: ()=>navigateTo(context, ImageScreen(content)),
                  child: Container(
                      height: 129,width: size!.width*.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart:Radius.circular(isUser?20:0),
                          topEnd: Radius.circular(isUser?0:20),
                          bottomEnd:const Radius.circular(20),
                          bottomStart:const Radius.circular(20),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child:ImageNet(image: content,)
                  ),
                );
              case Type.record:
                return Container(
                    decoration: BoxDecoration(
                      color: HexColor('#EEEEEE'),
                      borderRadius: BorderRadiusDirectional.only(
                        topStart:Radius.circular(isUser?20:0),
                        topEnd: Radius.circular(isUser?0:20),
                        bottomEnd:const Radius.circular(20),
                        bottomStart:const Radius.circular(20),
                      ),
                    ),
                    padding:const EdgeInsets.symmetric(horizontal: 10),
                    child:RecordItem(url: content,)
                );
              default:
                return const SizedBox();
            }
          },

          ),
        ],
      ),
    );
  }
}
