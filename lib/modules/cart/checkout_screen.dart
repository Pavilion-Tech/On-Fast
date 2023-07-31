import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/cubit/states.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/widgets/cart/checkout/pick_up.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';
import 'package:on_fast/widgets/item_shared/defult_form.dart';

import '../../widgets/cart/checkout/checkout_done.dart';
import '../../widgets/cart/checkout/checkout_list_item.dart';
import '../../widgets/cart/checkout/have_discount.dart';
import '../../widgets/cart/checkout/invoice.dart';
import '../../widgets/cart/checkout/payment_method.dart';
import '../../widgets/cart/checkout/pick_time.dart';
import '../../widgets/cart/checkout/select_sevice_type.dart';
import '../../widgets/item_shared/default_appbar.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({Key? key}) : super(key: key);

  SelectServiceType selectServiceType = SelectServiceType();
  PickUp pickUp = PickUp();
  PickTime pickTime = PickTime();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FastCubit,FastStates>(
        listener: (c,s){},
        builder: (context,state){
          return InkWell(
            onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: Column(
              children: [
                DefaultAppBar(tr('checkout')),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        CheckOutListItem(),
                        selectServiceType,
                        pickTime,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Image.asset(Images.calendar,width: 16,height: 16,),
                              const SizedBox(width: 3,),
                              Text(
                                '${tr('reservation')} ${DateFormat('EEEE',myLocale).format(pickTime.dateTime)} ${pickTime.dateTime.day}/${pickTime.dateTime.month}/${pickTime.dateTime.year} - ${pickTime.dateTime.hour}:${pickTime.dateTime.minute}'
                              ),
                            ],
                          ),
                        ),
                        if(selectServiceType.currentIndex==0)pickUp,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
                          child: Column(
                            children: [
                              if(selectServiceType.currentIndex==0)
                              if(pickUp.currentIndex ==0)
                              DefaultForm(
                                hint: tr('car_number'),
                                type: TextInputType.number,
                                onChange: (val){
                                },
                              ),
                              if(selectServiceType.currentIndex==1)
                                DefaultForm(
                                  hint: tr('number_of_people'),
                                  type: TextInputType.number,
                                  onChange: (val){
                                  },
                                ),
                              if(selectServiceType.currentIndex==0)
                                const SizedBox(height: 20,),
                              if(selectServiceType.currentIndex==0)
                                if(pickUp.currentIndex ==0)
                                DefaultForm(
                                hint: tr('color_of_car'),
                                onTap: (){
                                },
                              ),
                              if(pickUp.currentIndex ==0)
                                const SizedBox(height: 20,),
                              DefaultForm(
                                hint: tr('note'),
                                maxLines: 3,
                                onTap: (){
                                },
                              ),
                            ],
                          ),
                        ),
                        PaymentMethod(),
                        HaveDiscount(),
                        Invoice(),
                        DefaultButton(
                          onTap: (){
                            showDialog(
                                context: context,
                                builder: (context)=>CheckoutDone()
                            );
                          },
                          text: tr('place_order'),
                        ),
                        const SizedBox(height: 80,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
