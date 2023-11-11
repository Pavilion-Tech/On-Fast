import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';


class UTI{
  UTI._();
  static Widget backIcon()=>const Icon(Icons.arrow_back_ios);







  static showSnackBar(context, message, status) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: status == 'error' ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  static Future showToast ({required String msg , bool? toastState,ToastGravity gravity = ToastGravity.BOTTOM})
  {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: 5,
      textColor: Colors.white,
      fontSize: 16.0,
      backgroundColor: toastState != null
          ? toastState ?Colors.yellow[900]
          : Colors.red : Colors.green,
    );
  }

  static Widget dataEmptyWidget({required String noData, required String imageName,double? width,double? height}) => Center(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 35,),
          Center(child: SvgPicture.asset(imageName, fit: BoxFit.cover,width: width,height: height,)),
          const SizedBox(height: 30,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              noData,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    ),
  );
}