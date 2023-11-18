import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';

import '../../../../layout/cubit/states.dart';
import '../../../../widgets/item_shared/provider_item.dart';
import '../../shared/components/components.dart';
import 'add_new_address_screen.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  ScrollController gridController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FastCubit, FastStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = FastCubit.get(context);
          return Column(
            children: [
              DefaultAppBar(tr('Addresses')),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: AutoSizeText(
                        tr("Addresses"),
                        minFontSize: 8,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    addressList()

                  ],
                ),
              ),
            ],
          );
        },

      ),
    );
  }
  Widget addressList() {
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
                                    AutoSizeText(
                                      "26985 Brighton Lane, Lake Forest, CA 92630.",
                                      minFontSize: 8,
                                      maxLines: 1,
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
        SizedBox(height: 50,),
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
