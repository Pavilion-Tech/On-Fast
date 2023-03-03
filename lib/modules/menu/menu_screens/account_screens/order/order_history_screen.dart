import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/modules/home/search/seach_screen.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';
import 'package:on_fast/widgets/item_shared/defult_form.dart';

import '../../../../../widgets/item_shared/filter.dart';
import '../../../../../widgets/menu/order_widgets/filter_dialog.dart';
import '../../../../../widgets/menu/order_widgets/history_order_item.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(tr('orders_history')),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: DefaultForm(hint: tr('search_order'))),
                      const SizedBox(width: 20,),
                      FilterWidget(() {
                        showDialog(
                            context: context,
                            builder: (context)=>FilterDialog()
                        );
                      })
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (c,i)=>HistoryOrderItem(),
                        separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                        physics: const BouncingScrollPhysics(),
                        itemCount: 5
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
