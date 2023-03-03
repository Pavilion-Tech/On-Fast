import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/styles/colors.dart';

class Invoice extends StatelessWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          itemBuilder(
            text: 'subtotal',
            price: '10'
          ),
          itemBuilder(
            text: 'tax',
            price: '10'
          ),
          itemBuilder(
            text: 'app_fee',
            price: '10'
          ),
          itemBuilder(
            text: 'deposit',
            price: '10'
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
                  '40 AED',
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
  required String price,
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
