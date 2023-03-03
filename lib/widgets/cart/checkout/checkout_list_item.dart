import 'package:flutter/material.dart';
import 'package:on_fast/shared/styles/colors.dart';

import '../../../shared/images/images.dart';

class CheckOutListItem extends StatelessWidget {
  const CheckOutListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 470,
      child: ListView.separated(
          itemBuilder: (c,i)=>CheckOutItem(),
          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
          padding: EdgeInsetsDirectional.all(20),
          itemCount: 5
      ),
    );
  }
}

class CheckOutItem extends StatelessWidget {
  const CheckOutItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '1',
                      style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.w500,color: defaultColor),
                    ),
                    Text(
                      ' * ',
                      style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '79 AED',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

