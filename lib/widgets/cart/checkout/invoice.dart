import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/styles/colors.dart';

class Invoice extends StatelessWidget {
  Invoice({this.subtotal,this.total,this.appFee,this.tax,this.discount,this.discountType});

  dynamic subtotal;
  dynamic total;
  dynamic appFee;
  dynamic tax;
  dynamic discount;
  int? discountType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          itemBuilder(
            text: 'subtotal',
            price: subtotal??'10'
          ),
          itemBuilder(
            text: 'tax',
            price: tax??'10'
          ),
          itemBuilder(
            text: 'app_fee',
            price: appFee??'10'
          ),
          if(discount!=null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Text(
                    tr('discount'),
                    style:const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Text(
                    '$discount ${discountType == 2 ?'AED':'%'}',
                    style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                  ),
                ],
              ),
            ),
          Container(
            height: 1,
            width: double.infinity,color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Text(
                  tr('total_order'),
                  style:const TextStyle(fontWeight: FontWeight.w700,fontSize: 19),
                ),
                const Spacer(),
                Text(
                  '${total??40} AED',
                  style:TextStyle(fontWeight: FontWeight.w600,fontSize: 19,color: defaultColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget itemBuilder({
  required String text,
  required dynamic price,
}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Text(
            tr(text),
            style:const TextStyle(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text(
            '$price AED',
            style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
          ),
        ],
      ),
    );
  }
}
