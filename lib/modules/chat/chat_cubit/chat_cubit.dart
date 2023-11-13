import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


import '../../../../../layout/layout_screen.dart';
import '../../../../../shared/components/components.dart';



import '../../../../../shared/network/remote/dio.dart';
import '../../../../../shared/network/remote/end_point.dart';
import 'chat_sates.dart';


class ChatCubit extends Cubit<ChatStates>{

  ChatCubit ():super(ChatInitState());

  static ChatCubit get(context)=>BlocProvider.of(context);

  TextEditingController controller = TextEditingController();

  // ChatModel? chatModel;


  ImagePicker picker = ImagePicker();

  XFile? chatImage;

  void emitState()=>emit(EmitState());

  Future<XFile?> pick(ImageSource source)async{
    try{
      return await picker.pickImage(source: source,imageQuality: 1);
    } catch(e){
      print(e.toString());
      emit(ImageWrong());
    }
  }

  // void checkInterNet() async {
  //   InternetConnectionChecker().onStatusChange.listen((event) {
  //     final state = event == InternetConnectionStatus.connected;
  //     isConnect = state;
  //     emit(EmitState());
  //   });
  // }


  // void createChat(BuildContext context){
  //   DioHelper.postData(
  //     url:createChatUrl,
  //     token: 'Bearer $token'
  //   ).then((value) {
  //     if(value.data['data']!=null){
  //       chatId = value.data['data']['_id'];
  //       CacheHelper.saveData(key: 'chatId', value: chatId);
  //       emit(CreateChatSuccessState());
  //       Navigator.pop(context);
  //       navigateTo(context, ChatScreen());
  //     }else{
  //       showToast(msg: tr('wrong'));
  //       emit(CreateChatWrongState());
  //     }
  //   }).catchError((e){
  //     emit(CreateChatErrorState());
  //   });
  // }
  //
  // void getChat(){
  //   DioHelper.getData(
  //       url:'$getChatUrl$chatId',
  //       token: 'Bearer $token'
  //   ).then((value) {
  //     print(value.data);
  //     if(value.data['data']!=null){
  //       chatModel = ChatModel.fromJson(value.data);
  //       emit(CreateChatSuccessState());
  //     }else{
  //       showToast(msg: tr('wrong'));
  //       emit(CreateChatWrongState());
  //     }
  //   }).catchError((e){
  //     emit(CreateChatErrorState());
  //   });
  // }
  //
  // void endChat(BuildContext context){
  //   emit(EndChatLoadingState());
  //   DioHelper.postData(
  //       url:endChatUrl,
  //       token: 'Bearer $token',
  //     data: {
  //         'support_chat_id':chatId,
  //         'support_chat_status':2
  //     }
  //   ).then((value) {
  //     if(value.data['data']!=null){
  //       chatId = null;
  //       chatModel = null;
  //       CacheHelper.removeData('chatId');
  //       navigateAndFinish(context, LayoutScreen());
  //       emit(EndChatSuccessState());
  //     }else{
  //       showToast(msg: tr('wrong'));
  //       emit(EndChatWrongState());
  //     }
  //   }).catchError((e){
  //     emit(EndChatErrorState());
  //   });
  // }



  // void sendMessageWithFile({
  //   required int type,
  //   required File file,
  //   bool isRecord = false,
  // })async{
  //   FormData formData = FormData.fromMap({
  //     'support_chat_id':chatId,
  //     'message_type':type,
  //     'uploaded_message_file':MultipartFile.fromFileSync(file.path,
  //         filename: file.path.split('/').last),
  //   });
  //   emit(SendMessageWithFileLoadingState());
  //   DioHelper.postData2(
  //       url: sentMessageUrl,
  //       token: 'Bearer $token',
  //       formData:formData
  //   ).then((value) {
  //     print(value.data);
  //     if(value.data['status']==true){
  //       chatImage = null;
  //       emit(SendMessageSuccessState());
  //       getChat();
  //     }else{
  //       showToast(msg: tr('wrong'));
  //       emit(SendMessageWrongState());
  //     }
  //   }).catchError((e){
  //     showToast(msg: tr('wrong'));
  //     emit(SendMessageErrorState());
  //   });
  // }
  //
  // void sendMessageWithOutFile(){
  //   emit(SendMessageLoadingState());
  //   DioHelper.postData(
  //       url: sentMessageUrl,
  //       token: 'Bearer $token',
  //       data: {
  //         'support_chat_id':chatId,
  //         'message_type':1,
  //         'message':controller.text
  //       }
  //   ).then((value) {
  //     print(value);
  //     if(value.data['status']==true){
  //       controller.text = '';
  //       emit(SendMessageSuccessState());
  //       getChat();
  //     }else{
  //       showToast(msg: tr('wrong'));
  //       emit(SendMessageWrongState());
  //     }
  //   }).catchError((e){
  //     showToast(msg: tr('wrong'));
  //     emit(SendMessageErrorState());
  //   });
  // }
}