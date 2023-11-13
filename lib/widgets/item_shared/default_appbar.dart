import 'package:flutter/material.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/layout_screen.dart';
import 'package:on_fast/shared/styles/colors.dart';

import '../../shared/components/components.dart';
import '../../shared/images/images.dart';

class DefaultAppBar extends StatelessWidget {
  DefaultAppBar(this.title,{this.isCart = false, this.color});
 final String title;
 final bool isCart;
 final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 133,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
              height: 133,
              width: double.infinity,
              child: Image.asset(
                Images.bubbles,
                height: 133,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
          ),
          if(isCart)
          Text(
            title,
            style: TextStyle(color: defaultColor,fontSize: 20),
          ),
          if(!isCart)
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back_ios_outlined)),
                Text(
                  title,
                  style: TextStyle(color: defaultColor,fontSize: 20),
                ),
                InkWell(
                  onTap:color==null? (){
                    FastCubit.get(context).changeIndex(1);
                    navigateAndFinish(context,FastLayout());
                  }:null,
                    child: Image.asset(Images.cartYes,width: 25,color: color??defaultColor,),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
