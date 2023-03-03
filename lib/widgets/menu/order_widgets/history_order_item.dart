import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/components/components.dart';
import 'package:on_fast/shared/images/images.dart';

import '../../../modules/menu/menu_screens/account_screens/order/order_details_screen.dart';

class HistoryOrderItem extends StatelessWidget {
  const HistoryOrderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>navigateTo(context, OrderDetailsScreen()),
      child: SizedBox(
        height: 130,
        width: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: 97,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(15),
                color: Colors.grey.shade200
              ),
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${tr('order')}12',
                    style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Pick Up',
                    style:const TextStyle(fontSize: 9,fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Date 20June 2019',
                        style:const TextStyle(fontSize: 8),
                      ),
                      const Spacer(),
                      Text(
                        'Pending',
                        style:const TextStyle(fontSize: 12,fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 5,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle
                ),
                height: 84,width: 84,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(Images.homeImage,fit: BoxFit.cover,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
