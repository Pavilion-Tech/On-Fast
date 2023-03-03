import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../item_shared/product_item.dart';

class BrancheBottomSheet extends StatelessWidget {
  const BrancheBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text(
            tr('change_branch'),
            style:const TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
            child: ListView.separated(
              itemBuilder: (c,i)=>ProductItem(isBranch:true),
              separatorBuilder: (c,i)=>const SizedBox(height: 20,),
              itemCount: 5,
              padding: EdgeInsets.all(20),
            )
        )
      ],
    );
  }
}
