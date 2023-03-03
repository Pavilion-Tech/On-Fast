import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:on_fast/shared/images/images.dart';

import '../../shared/styles/colors.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 135,width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(27),
              color: Colors.grey.shade300
          ),
        ),
        Slidable(
          direction: Axis.horizontal,
          endActionPane: ActionPane(
            extentRatio: 0.12,
            motion: InkWell(
              onTap: (){},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:BorderRadiusDirectional.only(
                    topEnd: Radius.circular(27),
                    bottomEnd: Radius.circular(27),
                  ),
                  color: Colors.grey.shade300,
                ),
                padding: EdgeInsetsDirectional.all(14),
                child: Image.asset(Images.bin,width: 20,height: 20,),
              ),
            ),
            children: const[],
          ),
          child:Container(
            height: 135,width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(27),
                color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 20,
                ),   BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 20,
                ),
              ]
            ),
            child: Row(
              children: [
                Container(
                  height: 135,width: 135,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadiusDirectional.circular(27),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.asset(Images.homeImage,fit: BoxFit.cover,),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cheese Pizza',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '79 AED',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                      ),
                      Container(
                        height: 34,width: 96,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(58),
                          color: defaultColor.withOpacity(.3)
                        ),
                        padding:const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:const [
                            Text(
                              '+',
                              style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500),
                            ),
                            Text(
                              '1',
                              style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500),
                            ),
                            Text(
                              '-',
                              style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
