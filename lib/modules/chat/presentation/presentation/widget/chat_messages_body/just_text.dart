import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class MessageJustText extends StatelessWidget {
  const MessageJustText({
    super.key,
    required   this.isMe, required   this.message,

  });
  final bool isMe;
  final String message;





  @override
  Widget build(BuildContext context) {
    return Container(
        alignment:isMe? Alignment.topRight:Alignment.topLeft,
        child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.80),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                // color: isMe?Theme.of(context).primaryColor: AppColors.lightSky,
                borderRadius: isMe
                    ? const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )
                    : const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 2, blurRadius: 2)]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Html(
                  style: {
                    "body": Style(
                      fontSize: FontSize(14.0),
                      color:isMe?  Colors.white:Colors.black,
                    ),
                  },
                  data: message ?? "",
                ),
              ],
            )));
  }
}