import 'package:flutter/material.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';

class MenuAppBar extends StatelessWidget {
  const MenuAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 132,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius:const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(30),
                  bottomStart: Radius.circular(30),
              ),
              color: defaultColor
            ),
            child: Image.asset(Images.bubbles,height: 132,width: double.infinity,),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              height: 133,width: 133,
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(Images.profileImage),
            ),
          ),
        ],
      ),
    );
  }
}
