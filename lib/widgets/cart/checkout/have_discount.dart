import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/item_shared/defult_form.dart';

class HaveDiscount extends StatelessWidget {
  HaveDiscount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:const EdgeInsetsDirectional.only(top: 30.0,bottom: 10,start: 20),
          child: Text(
            tr('have_discount'),
            style:const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child:DefaultForm(
              hint: tr('enter_discount'),
            suffix: TextButton(
              child: Text(tr('apply'),style: TextStyle(color:defaultColor),),
              onPressed: (){},
            ),
          ),
        ),
      ],
    );
  }
}

