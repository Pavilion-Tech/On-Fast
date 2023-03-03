import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/cubit/states.dart';
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
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FastCubit,FastStates>(
        listener: (c,s){},
        builder: (context,state){
          return Column(
            children: [
              DefaultAppBar(tr('checkout')),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      CheckOutListItem(),
                      SelectServiceType(),
                      PickTime(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
                        child: Column(
                          children: [
                            DefaultForm(
                              hint: tr('number_of_people'),
                              type: TextInputType.number,
                              onChange: (val){
                                FocusManager.instance.primaryFocus!.unfocus();
                              },
                            ),
                            const SizedBox(height: 20,),
                            DefaultForm(
                              hint: tr('color_of_car'),
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
          );
        },
      ),
    );
  }
}
