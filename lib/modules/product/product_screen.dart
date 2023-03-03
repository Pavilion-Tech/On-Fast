import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/components/components.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';

import '../../widgets/item_shared/default_button.dart';
import '../../widgets/product/select_size.dart';
import '../../widgets/product/select_type.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(''),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 258,width: 258,
                        decoration:const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.asset(Images.homeImage,fit: BoxFit.cover,),
                      ),
                      Text(
                        'Cheese Pizza',
                        style:const TextStyle(fontSize: 35,fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('description'),
                          style:const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                          style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w300,color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            tr('select_size'),
                            style:const TextStyle(fontSize: 16),
                          ),
                        ),
                        SelectSize(),
                        Padding(
                          padding: const EdgeInsets.only(top: 50,bottom: 10),
                          child: Text(
                            tr('select_type'),
                            style:const TextStyle(fontSize: 16),
                          ),
                        ),
                        SelectType(),
                      ],
                    ),
                  ),
                  DefaultButton(
                    text:tr('add_to_cart'),
                    onTap: (){
                      showToast(msg: 'Item Added Successfully');
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
