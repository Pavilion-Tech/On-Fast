import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/components/components.dart';

import '../../../../modules/menu/menu_screens/account_screens/order/track_screen.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';

class FirstWidget extends StatelessWidget {
  const FirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              height: 65,width: 65,
              decoration:const BoxDecoration(
                  shape: BoxShape.circle
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(Images.homeImage,fit: BoxFit.cover,),
            ),
            Text(
              'Restaurant Name',
              style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 12),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Pick Up',
              style:const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: ()=>navigateTo(context, TrackScreen('New')),
              child: Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadiusDirectional.circular(7)
                ),
                child: Text(
                  'New | ${tr('track')}',
                  style:const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
