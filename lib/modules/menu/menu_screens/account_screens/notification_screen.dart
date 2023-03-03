import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultAppBar(tr('notifications')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: tr('you_have'),
                    style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                    children: [
                      TextSpan(
                          text: ' 3 ${tr('notifications')} ',
                          style: TextStyle(color: defaultColor,fontWeight: FontWeight.w500,fontSize: 15),
                        children: [
                          TextSpan(
                              text: tr('today'),
                              style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15)
                          )
                        ]
                      )
                    ]
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30,bottom: 8),
                  child: Text(
                    'Today',
                    style: TextStyle(color: defaultColor,fontSize: 13,fontWeight: FontWeight.w500),
                  ),
                ),
                NotificationItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: Colors.grey.shade200
      ),
      padding: EdgeInsetsDirectional.only(start: 15,end: 30,top: 5,bottom: 5),
      alignment: AlignmentDirectional.center,
      child: Row(
        children: [
          Container(
            height: 28,width: 28,
            decoration: BoxDecoration(
              color: HexColor('#f4cccc').withOpacity(.7),
              borderRadius: BorderRadiusDirectional.circular(5),
            ),
            alignment: AlignmentDirectional.center,
            child: Image.asset(Images.notification,width: 15,),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Order',
                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
                    ),
                    const Spacer(),
                    Text(
                      '30 Min Ago',
                      style: TextStyle(fontWeight: FontWeight.w500,fontSize: 8),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  'Your Order Has Been Delivered',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

