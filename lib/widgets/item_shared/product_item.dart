import 'package:flutter/material.dart';
import 'package:on_fast/shared/components/components.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/images/images.dart';

import '../../modules/restaurant/restaurant_screen.dart';

class ProductItem extends StatelessWidget {

  ProductItem ({this.isBranch = false});

  bool isBranch;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(isBranch){
          Navigator.pop(context);
        }else{
          navigateTo(context, RestaurantScreen());
        }
      },
      child: Container(
        width: double.infinity,
        height: 84,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          border: Border.all(color: Colors.grey)
        ),
        padding: const EdgeInsets.only(right: 5,left: 5,bottom: 5,top: 5),
        child: Row(
          children: [
            Container(
              height: 75,
              width: 75,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(15),
              ),
              child: Image.asset(Images.homeImage,fit: BoxFit.cover,),
            ),
            const SizedBox(width: 5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pizza Hat',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Pickup & Dine In Service',
                  style: TextStyle(fontSize: 11),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(Images.star,width: 15,),
                    const SizedBox(width: 5,),
                    Text(
                      '5.0 (200)',
                      style: TextStyle(fontSize: 10,color: Colors.grey),
                    ),
                    SizedBox(width: size!.width*.01,),
                    Image.asset(Images.location,width: 15,),
                    const SizedBox(width: 5,),
                    Text(
                      '3.5KM',
                      style: TextStyle(fontSize: 10,color: Colors.grey),
                    ),
                    SizedBox(width: size!.width*.01,),
                    Image.asset(Images.timer,width: 15,),
                    const SizedBox(width: 5,),
                    Text.rich(
                      TextSpan(
                        text:'9 - 10 Min | ',
                        style: TextStyle(fontSize: 10,color: Colors.grey),
                        children: [
                          TextSpan(
                            text: 'Crowded',
                            style: TextStyle(fontSize: 10)
                          )
                        ]
                      )
                    ),
                    SizedBox(width: size!.width*.01,),
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 5,
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      'Open',
                      style: TextStyle(fontSize: 10,color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
