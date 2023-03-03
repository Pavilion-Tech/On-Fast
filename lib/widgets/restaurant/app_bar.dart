import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/item_shared/product_item.dart';

import '../../shared/components/constant.dart';
import 'branche_bottom_sheet.dart';

class RestaurantAppBar extends StatelessWidget {
  const RestaurantAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 206,
          width: double.infinity,
          decoration:const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.asset(Images.homeImage,fit: BoxFit.cover,),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
          child: Container(
            width: double.infinity,
            height: 84,
            decoration: BoxDecoration(
              color: Colors.white,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Pizza Hat',
                              maxLines: 1,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              showModalBottomSheet(
                                  context: context,
                                  shape:const RoundedRectangleBorder(
                                    borderRadius: BorderRadiusDirectional.only(
                                      topEnd: Radius.circular(20),
                                      topStart: Radius.circular(20),
                                    )
                                  ),
                                  builder: (context)=>BrancheBottomSheet()
                              );
                            },
                            child: Text(
                              tr('change_branch'),
                              style: TextStyle(
                                color: defaultColor,
                                decoration: TextDecoration.underline,
                                fontSize: 9.4,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          const SizedBox(width: 20,)
                        ],
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
                ),
              ],
            ),
          ),
        ),
        Positioned.directional(
          top: 0,
          start: -10,
          textDirection: TextDirection.ltr,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: IconButton(
                onPressed: ()=>Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
