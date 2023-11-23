import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/cart/checkout/checkout_list_item.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';
import '../../../../../models/order_model.dart';
import '../../../../../widgets/cart/checkout/invoice.dart';
import '../../../../../widgets/cart/checkout/payment_method.dart';
import '../../../../../widgets/menu/order_widgets/order_details_widgets/booking_date.dart';
import '../../../../../widgets/menu/order_widgets/order_details_widgets/first_widget.dart';
import '../../../../../widgets/menu/order_widgets/order_details_widgets/info.dart';
import '../../../../../widgets/menu/order_widgets/order_details_widgets/note.dart';
import '../../../../../widgets/menu/order_widgets/order_details_widgets/payment_item.dart';
import '../../../../../widgets/menu/order_widgets/order_details_widgets/pick_time.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen(this.data);

  OrderData data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar('${tr('order')}${data.itemNumber??'0'}'),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FirstWidget(data),
                    SizedBox(
                      height: data.products!.length == 1?200:480,
                      child: ListView.separated(
                          itemBuilder: (c,i)=>OrderItem(products: data.products![i]),
                          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          physics: const BouncingScrollPhysics(),
                          itemCount: data.products!.length,
                      ),
                    ),
                    PickUpTime(data.createdAt??''),
                    const SizedBox(height: 20,),
                    AutoSizeText(
                      tr('food_type'),
                      minFontSize: 8,
                      maxLines: 1,
                      style:const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10,),
                    AutoSizeText(
                      '${tr(data.dinnerType==1?'breakfast':data.dinnerType==2?'lunch':'dinner')}',
                      minFontSize: 6,
                      maxLines: 1,
                      style:const TextStyle(fontSize: 10,fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20,),
                    if(data.serviceType ==1&&data.colorOfCar !=null)
                    Info(
                      title: tr('more_information'),
                      subSubTitle: data.serviceType == 1 ?tr('car_number'):null,
                      subTitle: data.serviceType == 1 ?tr('color_of_car'):tr('number_of_people'),
                      subSubTitleDesc: data.serviceType == 1 ?data.numberOfCar??'':null,
                      subTitleDesc: data.serviceType ==1 ?data.colorOfCar??'':data.noOfPeople.toString(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: PaymentItem(PaymentMethodModel(title: tr('pay_on_delivery'),method: 'cash'),),
                    ),
                    if(data.additionalNotes!=null)
                    Note(data.additionalNotes!),
                    Invoice(
                      delivery: data.shippingCharges??"",
                      selectServiceType:data.serviceType ,
                      total: data.totalPrice,
                      // appFee: data.appFees,
                      subtotal: data.subTotalPrice,
                      tax: data.vatValue,
                    ),
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
