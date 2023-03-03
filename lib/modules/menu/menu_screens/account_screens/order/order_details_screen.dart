import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/cart/checkout/checkout_list_item.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';
import '../../../../../widgets/cart/checkout/invoice.dart';
import '../../../../../widgets/cart/checkout/payment_method.dart';
import '../../../../../widgets/menu/order_widgets/order_details_widgets/booking_date.dart';
import '../../../../../widgets/menu/order_widgets/order_details_widgets/first_widget.dart';
import '../../../../../widgets/menu/order_widgets/order_details_widgets/info.dart';
import '../../../../../widgets/menu/order_widgets/order_details_widgets/note.dart';
import '../../../../../widgets/menu/order_widgets/order_details_widgets/payment_item.dart';
import '../../../../../widgets/menu/order_widgets/order_details_widgets/pick_time.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar('${tr('order')}12'),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FirstWidget(),
                    SizedBox(
                      height: 480,
                      child: ListView.separated(
                          itemBuilder: (c,i)=>CheckOutItem(),
                          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          physics: const BouncingScrollPhysics(),
                          itemCount: 4,
                      ),
                    ),
                    PickUpTime(),
                    const SizedBox(height: 20,),
                    BookingDate(),
                    const SizedBox(height: 20,),
                    Info(
                      title: 'More Information',
                      subSubTitle: 'Tables Number',
                      subTitle: 'Number Of People',
                      subSubTitleDesc: '5',
                      subTitleDesc: '7-5-10',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: PaymentItem(PaymentMethodModel(image: Images.visa),),
                    ),
                    Note(),
                    Invoice(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
