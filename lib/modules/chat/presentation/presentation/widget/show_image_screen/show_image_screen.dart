import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/shared/styles/colors.dart';

import '../../../../../../shared/components/uti.dart';
import '../../../../../../widgets/item_shared/Text_form.dart';
import '../../../../data/request/send_message_request.dart';
 import '../../../cubit/chat_msg_cubit/chat_msg_cubit.dart';
import '../../../cubit/chat_msg_cubit/chat_msg_state.dart';



class ShowImageScreen extends StatefulWidget {
  const ShowImageScreen({super.key, required this.path, required this.id });

  final String path;
  final int id;

  @override
  State<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  VideoPlayerController? controller;
     String? filePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!UTI.imageExtensions.contains(widget.path.split('.').last)) {
      controller = VideoPlayerController.file(File(widget.path))
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatMsgCubit, ChatMsgState>(
      listener: (context, state) {
        if (state is AddToMessageListState) {
          Navigator.pop(context);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                   if((UTI.imageExtensions.contains(widget.path.split('.').last)))
                  SizedBox(
                        child: Image.file(
                          File(widget.path),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      )
                      else const Center(child: CircularProgressIndicator()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                children: [
                                  if(UTI.docExtensions.contains(widget.path.split('.').last))
                                    Expanded(child: Container()),
                                  if(!UTI.docExtensions.contains(widget.path.split('.').last))

                                  Expanded(
                                    child: InputTextFormField(
                                       textEditingController: ChatMsgCubit.get(context)
                                          .captionImageMessage,
                                      prefixIcon: const Icon(Icons.add_a_photo_outlined),
                                      maxLines: 5,
                                      minLines: 1, hintText: 'Add Caption', validator: (String ) {  },


                                    ),
                                  ),
                                  const SizedBox(width: 10,),

                                  CircleAvatar(
                                    backgroundColor: defaultColor,
                                    radius: 25,
                                    child: IconButton(
                                      onPressed: () {
                                        print("imagePath");
                                        print(widget.path);
                                        final extension = widget.path.substring(widget.path.lastIndexOf('.') + 1);

                                        SendMessageRequest sendMsg = SendMessageRequest(
                                          type:  checkType(extension),
                                          message: ChatMsgCubit.get(context).captionImageMessage.text,
                                          // roomId: widget.usersData.chatRoomId.toString(),
                                          // roomType: widget.usersData.chatRoomType??"",
                                          // to: widget.usersData.to.toString(),
                                          image:UTI.imageExtensions.contains(extension)?widget.path:null,
                                          video:UTI.videoExtensions.contains(extension)?widget.path:null,
                                          doc: UTI.docExtensions.contains(extension)?widget.path:null,

                                        );
                                        ChatMsgCubit.get(context).sendMessage(sendMessageRequest: sendMsg);
                                        // PusherService.pusherHelper.onTriggerEventPressed(context);
                                        ChatMsgCubit.get(context).captionImageMessage.clear();

                                      },
                                      icon: const Center(
                                        child: Icon(
                                          Icons.send,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(height: 20,)


                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
      },
    );
  }

  String? extensionPath(String extension) {
    var path;
    if(UTI.videoExtensions.contains(extension)){
      path=widget.path;
    }else if(UTI.docExtensions.contains(extension)){
      print("asnmdnsnkjfskjkfsjfs");
      path=widget.path;
    }else   if(UTI.imageExtensions.contains(extension)){
      print("asnmdnsnkjfskjkfsjfs213233232343");
      path=widget.path;
    }else {
      print("asnmdnsnkjfskjkfsjfs111111");
      path=null;

    }
    return path;
  }

  String checkType(String extension) {
    var type;
    if(UTI.videoExtensions.contains(extension)){
      type="video";
    }else if(UTI.docExtensions.contains(extension)){
      type="doc";
    }else   if(UTI.imageExtensions.contains(extension)){
    type="image";
    }
    return type;
  }
}
