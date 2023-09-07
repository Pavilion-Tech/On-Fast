import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
  PaymentMethod paymentMethod = PaymentMethod();
  late HaveDiscount haveDiscount;

  TextEditingController noteController = TextEditingController();
  TextEditingController noPeopleController = TextEditingController();
  TextEditingController noCarController = TextEditingController();
  TextEditingController carColorController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String? dropVal;

  @override
  Widget build(BuildContext context) {
    haveDiscount = HaveDiscount(couponController);
    return Scaffold(
      body: BlocConsumer<FastCubit,FastStates>(
        listener: (c,s){
          if(s is CreateOrderSuccessState){
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context)=>CheckoutDone(s.id)
            );
          }
        },
        builder: (context,state){
          var cubit = FastCubit.get(context);
          return InkWell(
            onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: Column(
              children: [
                DefaultAppBar(tr('checkout')),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
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
                                  '${tr('reservation')} ${DateFormat.yMEd().add_jms().format(pickTime.dateTime)}'
                                ),
                              ],
                            ),
                          ),
                          if(selectServiceType.currentIndex==1)pickUp,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30),
                            child: Column(
                              children: [
                                if(selectServiceType.currentIndex==1)
                                if(pickUp.currentIndex ==0)
                                DefaultForm(
                                  hint: tr('car_number'),
                                  controller: noCarController,
                                  onChange: (s){
                                    formKey.currentState!.validate();
                                  },
                                  validator: (str){
                                    if(str.isEmpty)return tr('car_number_empty');
                                  },
                                ),
                                if(selectServiceType.currentIndex==2)
                                    DefaultForm(
                                    hint: tr('number_of_people'),
                                    onChange: (s){
                                      formKey.currentState!.validate();
                                    },
                                    type: TextInputType.number,
                                    controller: noPeopleController,
                                    validator: (str){
                                      if(str.isEmpty)return tr('number_of_people_empty');
                                    },
                                  ),
                                 if(selectServiceType.currentIndex==1)
                                  const SizedBox(height: 20,),
                                if(selectServiceType.currentIndex==1)
                                  if(pickUp.currentIndex ==0)
                                  DefaultForm(
                                  hint: tr('color_of_car'),
                                    controller: carColorController,
                                    onChange: (s){
                                      formKey.currentState!.validate();
                                    },
                                    validator: (str){
                                      if(str.isEmpty)return tr('color_of_car_empty');
                                    },
                                ),
                                if(pickUp.currentIndex ==0)
                                  const SizedBox(height: 20,),
                                DefaultForm(
                                  hint: tr('note'),
                                  maxLines: 3,
                                  controller: noteController,
                                ),
                                if(selectServiceType.currentIndex!=1)
                                  const SizedBox(height: 20,),
                                if(selectServiceType.currentIndex!=1)
                                DropdownButtonFormField(
                                    items: [
                                      DropdownMenuItem(
                                          child: Text(
                                            tr('breakfast'),
                                          ),
                                        value: 'breakfast',
                                      ),
                                      DropdownMenuItem(
                                          child: Text(
                                            tr('lunch'),
                                          ),
                                        value: 'lunch',
                                      ),
                                      DropdownMenuItem(
                                          child: Text(
                                            tr('dinner'),
                                          ),
                                        value: 'dinner',
                                      ),
                                    ],
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        borderSide: BorderSide(color: Colors.grey)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          borderSide: BorderSide(color: Colors.grey)
                                      ),
                                    ),
                                    hint: Text(tr('breakfast')),
                                    value:dropVal,
                                    onChanged: (String? string){
                                      dropVal = string;
                                    }
                                )
                              ],
                            ),
                          ),
                          paymentMethod,
                          if(cubit.couponModel==null)
                            haveDiscount,
                          Invoice(
                            discount: cubit.couponModel?.data?.discountValue,
                            discountType: cubit.couponModel?.data?.discountType,
                            tax: cubit.cartModel?.data?.data?.invoiceSummary?.vatValue??'',
                            subtotal:  cubit.cartModel?.data?.data?.invoiceSummary?.subTotalPrice??'',
                            appFee:  cubit.cartModel?.data?.data?.invoiceSummary?.appFees??'',
                            total:  cubit.couponModel!=null
                                ?cubit.couponModel?.data?.discountType == 1
                                ?cubit.cartModel!.data!.data!.invoiceSummary!.totalPrice! - (cubit.cartModel!.data!.data!.invoiceSummary!.totalPrice!/cubit.couponModel!.data!.discountValue!).round()
                                :(cubit.cartModel!.data!.data!.invoiceSummary!.totalPrice! - cubit.couponModel!.data!.discountValue!)
                                :cubit.cartModel?.data?.data?.invoiceSummary?.totalPrice??'',
                          ),
                          ConditionalBuilder(
                            condition: state is! CreateOrderLoadingState,
                            fallback: (c)=>Center(child: CupertinoActivityIndicator(),),
                            builder: (c)=> DefaultButton(
                              onTap: (){
                                if(formKey.currentState!.validate()){
                                  FastCubit.get(context).createOrder(
                                    date: '${pickTime.dateTime.month}-${pickTime.dateTime.day}-${pickTime.dateTime.year} ${pickTime.dateTime.hour}:${pickTime.dateTime.minute}:${pickTime.dateTime.second}',
                                    paymentMethod: paymentMethod.method,
                                    serviceType: selectServiceType.currentIndex,
                                    couponCode:haveDiscount.controller.text.isNotEmpty?haveDiscount.controller.text:null,
                                    colorOfCar:carColorController.text.isNotEmpty?carColorController.text:null,
                                    noOfPeople:noPeopleController.text.isNotEmpty?noPeopleController.text:null,
                                    additionalNotes:noteController.text.isNotEmpty?noteController.text:null,
                                    noOfCar: noCarController.text.isNotEmpty?noCarController.text:null,
                                    foodType: dropVal!=null ?1:dropVal == 'breakfast'?1:dropVal == 'lunch'?2:3
                                  );
                                }else{
                                  print('hi');
                                }
                              },
                              text: tr('place_order'),
                            ),
                          ),
                          const SizedBox(height: 80,)
                        ],
                      ),
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
