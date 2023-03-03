import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';

class NotifyDialog extends StatelessWidget {
  const NotifyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding:const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(20)
      ),
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 70),
        child: InkWell(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: ()=>Navigator.pop(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Images.notifyDialog,width: 200,),
              Text(
                tr('done'),
                style: TextStyle(color: defaultColor,fontSize: 35,fontWeight: FontWeight.w600),
              ),
              Text(
                tr('we_will_notify'),
                textAlign: TextAlign.center,
                style:const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
