import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';

class NoCarts extends StatelessWidget {
  const NoCarts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.noCart),
          const SizedBox(height: 15,),
          // Text(
          //   tr('opps'),
          //   style: TextStyle(
          //     color: defaultColor,
          //     fontSize: 35,fontWeight: FontWeight.w600
          //   ),
          // ),
          Text(
            tr('cart_empty'),
            style: TextStyle(
              fontSize: 13,color: Colors.grey
            ),
          ),
          Text(
            tr('please_add_cart'),
            style: TextStyle(
              fontSize: 15,fontWeight: FontWeight.w600
            ),
          ),
          const SizedBox(height: 30,),
          DefaultButton(
              text: tr('start_shopping'),
              onTap: (){
                FastCubit.get(context).changeIndex(0);
              }
          )
        ],
      ),
    );
  }
}
