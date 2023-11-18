import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/cubit/states.dart';
import 'package:on_fast/modules/addresses/add_new_address_screen.dart';
import 'package:on_fast/shared/components/components.dart';
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
  TextEditingController noOfTableController = TextEditingController();
  TextEditingController noCarController = TextEditingController();
  TextEditingController carColorController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String? dropVal;

  @override
  Widget build(BuildContext context) {
    haveDiscount = HaveDiscount(couponController);
    return Scaffold(
      body: BlocConsumer<FastCubit, FastStates>(
        listener: (c, s) {
          if (s is CreateOrderSuccessState) {
            showDialog(context: context, barrierDismissible: false, builder: (context) => CheckoutDone(s.id));
          }
        },
        builder: (context, state) {
          var cubit = FastCubit.get(context);
          return InkWell(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
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
                          // if(selectServiceType.currentIndex==2)pickTime,
                          if (selectServiceType.currentIndex == 3)
                            SizedBox(
                              height: 10,
                            ),
                          if (selectServiceType.currentIndex == 3)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                children: [
                                  // Image.asset(Images.calendar,width: 16,height: 16,),
                                  // const SizedBox(width: 3,),
                                  AutoSizeText(
                                    // '${tr('reservation')} ${DateFormat.yMEd().add_jms().format(pickTime.dateTime)}'
                                    '${tr('Dine_In_Time')}',
                                    minFontSize: 8,
                                    maxLines: 1,
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          // if(selectServiceType.currentIndex==2)pickUp,

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                            child: Column(
                              children: [
                                if (selectServiceType.currentIndex == 1)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: AutoSizeText(
                                          tr("Select_Address"),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (selectServiceType.currentIndex == 1) addressList(context),
                                // if(selectServiceType.currentIndex==2)
                                // if(pickUp.currentIndex ==0)
                                // DefaultForm(
                                //   hint: tr('car_number'),
                                //   controller: noCarController,
                                //   onChange: (s){
                                //     formKey.currentState!.validate();
                                //   },
                                //   validator: (str){
                                //     if(str.isEmpty)return tr('car_number_empty');
                                //     return null;
                                //   },
                                // ),

                                if (selectServiceType.currentIndex == 3)
                                  DefaultForm(
                                    hint: tr('number_of_people'),
                                    onChange: (s) {
                                      formKey.currentState!.validate();
                                    },
                                    type: TextInputType.number,
                                    controller: noPeopleController,
                                    validator: (str) {
                                      if (str.isEmpty) return tr('number_of_people_empty');
                                      return null;
                                    },
                                  ),
                                // if(selectServiceType.currentIndex==2)
                                //   const SizedBox(height: 20,),
                                if (selectServiceType.currentIndex == 3)
                                  const SizedBox(
                                    height: 20,
                                  ),
                                if (selectServiceType.currentIndex == 3)
                                  DefaultForm(
                                    hint: tr('number_of_table'),
                                    onChange: (s) {
                                      formKey.currentState!.validate();
                                    },
                                    type: TextInputType.number,
                                    controller: noOfTableController,
                                    validator: (str) {
                                      if (str.isEmpty) return tr('number_of_table_empty');
                                      return null;
                                    },
                                  ),
                                // if(selectServiceType.currentIndex==3)
                                //  const SizedBox(height: 20,),
                                // if(selectServiceType.currentIndex==2)
                                //   if(pickUp.currentIndex ==0)
                                //   DefaultForm(
                                //   hint: tr('color_of_car'),
                                //     controller: carColorController,
                                //     onChange: (s){
                                //       formKey.currentState!.validate();
                                //     },
                                //     validator: (str){
                                //       if(str.isEmpty)return tr('color_of_car_empty');
                                //       return null;
                                //     },
                                // ),
                                if (pickUp.currentIndex == 0)
                                  const SizedBox(
                                    height: 20,
                                  ),
                                if(selectServiceType.currentIndex !=1)
                                DefaultForm(
                                  hint: tr('note'),
                                  maxLines: 3,
                                  controller: noteController,
                                ),
                                // if(selectServiceType.currentIndex!=1)
                                //   const SizedBox(height: 20,),
                                // if(selectServiceType.currentIndex!=1)
                                // DropdownButtonFormField(
                                //     items: [
                                //       DropdownMenuItem(
                                //           child: Text(
                                //             tr('breakfast'),
                                //           ),
                                //         value: 'breakfast',
                                //       ),
                                //       DropdownMenuItem(
                                //           child: Text(
                                //             tr('lunch'),
                                //           ),
                                //         value: 'lunch',
                                //       ),
                                //       DropdownMenuItem(
                                //           child: Text(
                                //             tr('dinner'),
                                //           ),
                                //         value: 'dinner',
                                //       ),
                                //     ],
                                //     decoration: InputDecoration(
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.all(Radius.circular(15)),
                                //         borderSide: BorderSide(color: Colors.grey)
                                //       ),
                                //       enabledBorder: OutlineInputBorder(
                                //           borderRadius: BorderRadius.all(Radius.circular(15)),
                                //           borderSide: BorderSide(color: Colors.grey)
                                //       ),
                                //     ),
                                //     hint: Text(tr('breakfast')),
                                //     value:dropVal,
                                //     onChanged: (String? string){
                                //       dropVal = string;
                                //     }
                                // )
                              ],
                            ),
                          ),
                          paymentMethod,
                          if (cubit.couponModel == null) haveDiscount,
                          Invoice(
                            delivery: 10,
                            discount: cubit.couponModel?.data?.discountValue,
                            discountType: cubit.couponModel?.data?.discountType,
                            tax: cubit.cartModel?.data?.data?.invoiceSummary?.vatValue ?? '',
                            subtotal: cubit.cartModel?.data?.data?.invoiceSummary?.subTotalPrice ?? '',
                            appFee: cubit.cartModel?.data?.data?.invoiceSummary?.appFees ?? '',
                            total: cubit.couponModel != null
                                ? cubit.couponModel?.data?.discountType == 1
                                    ? cubit.cartModel!.data!.data!.invoiceSummary!.totalPrice! -
                                        (cubit.cartModel!.data!.data!.invoiceSummary!.totalPrice! / cubit.couponModel!.data!.discountValue!).round()
                                    : (cubit.cartModel!.data!.data!.invoiceSummary!.totalPrice! - cubit.couponModel!.data!.discountValue!)
                                : cubit.cartModel?.data?.data?.invoiceSummary?.totalPrice ?? '',
                          ),
                          ConditionalBuilder(
                            condition: state is! CreateOrderLoadingState,
                            fallback: (c) => Center(
                              child: CupertinoActivityIndicator(),
                            ),
                            builder: (c) => DefaultButton(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  FastCubit.get(context).createOrder(
                                      date:
                                          '${pickTime.dateTime.month}-${pickTime.dateTime.day}-${pickTime.dateTime.year} ${pickTime.dateTime.hour}:${pickTime.dateTime.minute}:${pickTime.dateTime.second}',
                                      paymentMethod: paymentMethod.method,
                                      serviceType: selectServiceType.currentIndex,
                                      couponCode: haveDiscount.controller.text.isNotEmpty ? haveDiscount.controller.text : null,
                                      colorOfCar: carColorController.text.isNotEmpty ? carColorController.text : null,
                                      noOfPeople: noPeopleController.text.isNotEmpty ? noPeopleController.text : null,
                                      additionalNotes: noteController.text.isNotEmpty ? noteController.text : null,
                                      noOfCar: noCarController.text.isNotEmpty ? noCarController.text : null,
                                      foodType: dropVal != null
                                          ? 1
                                          : dropVal == 'breakfast'
                                              ? 1
                                              : dropVal == 'lunch'
                                                  ? 2
                                                  : 3);
                                } else {
                                  print('hi');
                                }
                              },
                              text: tr('place_order'),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          )
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

  Widget addressList(context) {
    return Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // AddressCubit.get(context).setDefaultAddress(addressId: addressesCubit.addressesData[index].id.toString(), context: context);
                },
                child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      // margin: EdgeInsets.symmetric(horizontal:   20, vertical:  10),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffB3B3B3).withOpacity(0.3),
                        // border: addressesCubit.addressesData[index].isDefault==true? Border.all(
                        //   color: AppColors.primary, // Set the border color here
                        //   width: 1, // Set the border width here
                        // ):null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                AutoSizeText(
                                  "GYM",
                                  minFontSize: 8,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff3B3B3B)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(Images.location1),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "26985 Brighton Lane, Lake Forest, CA 92630.",

                                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff5C5C5C)),

                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                // Navigator.pushNamed(context, Routes.addNewAddressScreen,
                                //     arguments: UpdateAddressRequest(
                                //       addressId:addressesCubit.addressesData[index].id.toString() ,
                                //       addressDetails:addressesCubit.addressesData[index].address.toString() ,
                                //       latitude: addressesCubit.addressesData[index].latitude.toString(),
                                //       longitude:  addressesCubit.addressesData[index].longitude.toString(),
                                //       title:  addressesCubit.addressesData[index].title.toString(),));
                              },
                              child: SvgPicture.asset(Images.edit))
                        ],
                      ),
                    )),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: 3),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: DefaultButton(
            height: 50,
            onTap: (){
               navigateTo(context, AddNewAddressScreen());
            },
            text: tr('Add_New_Address'),
          ),
        ),
      ],
    );
  }
}
