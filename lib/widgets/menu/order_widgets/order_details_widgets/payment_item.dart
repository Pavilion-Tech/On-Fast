import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/widgets/cart/checkout/payment_method.dart';

import '../../../../shared/styles/colors.dart';

class PaymentItem extends StatelessWidget {
  PaymentItem(this.model);

  PaymentMethodModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          tr('payment_method'),
          minFontSize: 8,
          maxLines: 1,
          style:const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10,),
        Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadiusDirectional.circular(10)
          ),
          padding:const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            children: [
              if(model.image!=null)
                Image.asset(model.image!,width: 54,),
              if(model.title!=null)
                AutoSizeText(model.title??"",
                  minFontSize: 8,
                  maxLines: 1,style:const TextStyle(fontSize: 16),),
              const Spacer(),
              CircleAvatar(
                radius: 9,
                backgroundColor: Colors.grey.shade400,
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: defaultColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}