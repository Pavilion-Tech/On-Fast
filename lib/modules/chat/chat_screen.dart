// import 'dart:async';
//
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:on_fast/modules/chat/presentation/cubit/chat_msg_cubit/chat_msg_cubit.dart';
// import 'package:on_fast/modules/chat/presentation/cubit/chat_msg_cubit/chat_msg_state.dart';
//
// import '../../../../shared/styles/colors.dart';
// import '../../widgets/chat/chat_body.dart';
// import '../../widgets/chat/chat_bottom.dart';
// import '../../widgets/item_shared/default_appbar.dart';
//
//
//
//
// class ChatScreen extends StatefulWidget {
//
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//
//   Timer timer = Timer(Duration.zero, () { });
//
//   @override
//   void initState() {
//     // if(chatId==null){
//     //   ChatCubit.get(context).createChat(context);
//     // }else{
//     //   ChatCubit.get(context).getChat();
//     //   timer = Timer.periodic(const Duration(seconds: 10), (timer) {
//     //     ChatCubit.get(context).getChat();
//     //   });
//     // }
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocConsumer<ChatMsgCubit, ChatMsgState >(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           body: InkWell(
//             onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//             overlayColor: MaterialStateProperty.all(Colors.transparent),
//             child: Column(
//               children: [
//                 DefaultAppBar( "",color: Colors.white),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 20),
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: ChatBody(),
//                         ),
//                         // ChatBottom()
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
