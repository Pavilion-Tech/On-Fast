import 'package:flutter/material.dart';
import 'package:on_fast/shared/components/components.dart';

import '../../modules/product/product_screen.dart';
import '../../shared/images/images.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigateTo(context, ProductScreen());
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cheese Pizza',
                    style: TextStyle(fontSize: 15),
                  ),
                  const Spacer(),
                  Text(
                    '79 AED',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
