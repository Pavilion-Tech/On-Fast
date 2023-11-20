import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';
import '../../../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/uti.dart';
import '../../widgets/shimmer/notification_shimmer.dart';
import 'add_new_address_screen.dart';
import 'cubit/address_cubit/address_cubit.dart';
import 'cubit/address_cubit/address_state.dart';
import 'data/request/update_address_request.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  ScrollController gridController = ScrollController();
  @override
  void initState() {
    super.initState();
    AddressCubit.get(context).getAddresses();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(tr('Addresses')),
          SizedBox(height: 20,),
          Expanded(
            child: BlocConsumer<AddressCubit, AddressState>(
              listener: (context, state) {
                if (state is SetDefaultAddressLoadState) {
                  UTI.showProgressIndicator(context);
                }
                if (state is SetDefaultAddressErrorState) {
                  Navigator.pop(context);
                }
                if (state is SetDefaultAddressSuccessState) {
                  Navigator.pop(context);
                }

                if (state is DeleteAddressLoadState) {
                  UTI.showProgressIndicator(context);
                }
                if (state is DeleteAddressErrorState) {
                  Navigator.pop(context);
                }
                if (state is DeleteAddressSuccessState) {
                  Navigator.pop(context);
                  AddressCubit.get(context).addressesData.clear();
                  AddressCubit.get(context).getAddresses();
                }
              },
              builder: (context, state) {
                var addressesCubit = AddressCubit.get(context);
                if (addressesCubit.addressesData.isEmpty && state is AddressesLoadState) {
                  return const NotificationShimmer();
                  // return Center(child: UTI.loadingWidget(),);
                }
                if (addressesCubit.addressesData.isEmpty && state is AddressesSuccessState) {
                  return Column(
                    children: [
                      const SizedBox(
                        height:  50,
                      ),
                      UTI.dataEmptyWidget(noData: tr("noDataFounded"), imageName: Images.productNotFound),
                      const SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          navigateTo(context, AddNewAddressScreen(updateAddressRequest: UpdateAddressRequest(),));
                          // Navigator.pushNamed(context, Routes.addNewAddressScreen, arguments: UpdateAddressRequest());
                        },
                        child: Container(
                          padding: const EdgeInsets.all( 20),
                          margin: const EdgeInsets.symmetric(horizontal:  20),
                          decoration: BoxDecoration(
                            color: defaultColor,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tr("Addresses"),
                                style: TextStyle(fontSize:  16, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                              const SizedBox(
                                width:  10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color:  Colors.white,
                                  shape: BoxShape.circle,
                                  // borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: defaultColor,
                                      size: 12,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (state is AddressesErrorState) {
                  return UTI.dataEmptyWidget(noData:  tr("noDataFounded"), imageName: Images.productNotFound);
                }
                return Padding(
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

                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {

                              return addressesItem(context, addressesCubit, index);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: addressesCubit.addressesData.length),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      DefaultButton(
                        text:  tr("Add_New_Address"),
                        onTap: () {
                          navigateTo(context, AddNewAddressScreen(updateAddressRequest: UpdateAddressRequest()));
                          // Navigator.pushNamed(context, Routes.addNewAddressScreen, arguments: UpdateAddressRequest());
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget addressesItem(BuildContext context, AddressCubit addressesCubit, int index) {
    return  Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              color: Color(0xffB3B3B3).withOpacity(0.3)
          ),
        ),
        Slidable(
          direction: Axis.horizontal,
          endActionPane: ActionPane(
            extentRatio: 0.12,
            motion: InkWell(
              onTap: (){
                AddressCubit.get(context).deleteAddress(addressId: addressesCubit.addressesData[index].id.toString(), context: context);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:const BorderRadiusDirectional.only(
                      topEnd: Radius.circular(10),
                      bottomEnd: Radius.circular(10),
                    ),
                    color: Color(0xffB3B3B3).withOpacity(0.3)
                ),
                padding: const EdgeInsetsDirectional.all(14),
                child: Image.asset(Images.bin,width: 20,height: 20,),
              ),
            ),
            children: const[],
          ),
          child: GestureDetector(
            onTap: () {
              AddressCubit.get(context).setDefaultAddress(addressId: addressesCubit.addressesData[index].id.toString(), context: context);
            },
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal:   20, vertical:  10),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffB3B3B3).withOpacity(0.3),
                    border: addressesCubit.addressesData[index].isDefault == true
                        ? Border.all(
                      color: defaultColor, // Set the border color here
                      width: 1, // Set the border width here
                    )
                        : null,
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
                            Text(
                              addressesCubit.addressesData[index].title ?? "",
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
                                Expanded(
                                  child: AutoSizeText(
                                    addressesCubit.addressesData[index].address ?? "",
                                    maxLines: 3,
                                    minFontSize: 10,
                                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff5C5C5C)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            navigateTo(context, AddNewAddressScreen(updateAddressRequest:  UpdateAddressRequest(
                              addressId: addressesCubit.addressesData[index].id.toString(),
                              addressDetails: addressesCubit.addressesData[index].address.toString(),
                              latitude: addressesCubit.addressesData[index].latitude.toString(),
                              longitude: addressesCubit.addressesData[index].longitude.toString(),
                              title: addressesCubit.addressesData[index].title.toString(),
                            )));

                          },
                          child: SvgPicture.asset(Images.edit))
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
// Widget addressList() {
//   return Column(
//     children: [
//       ListView.separated(
//           shrinkWrap: true,
//           padding: EdgeInsets.zero,
//           physics: NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 // AddressCubit.get(context).setDefaultAddress(addressId: addressesCubit.addressesData[index].id.toString(), context: context);
//               },
//               child: Padding(
//                   padding: const EdgeInsets.all(1.0),
//                   child: Container(
//                     // margin: EdgeInsets.symmetric(horizontal:   20, vertical:  10),
//                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Color(0xffB3B3B3).withOpacity(0.3),
//                       // border: addressesCubit.addressesData[index].isDefault==true? Border.all(
//                       //   color: AppColors.primary, // Set the border color here
//                       //   width: 1, // Set the border width here
//                       // ):null,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               AutoSizeText(
//                                 "GYM",
//                                 minFontSize: 8,
//                                 maxLines: 1,
//                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff3B3B3B)),
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Row(
//                                 children: [
//                                   SvgPicture.asset(Images.location1),
//                                   SizedBox(
//                                     width: 3,
//                                   ),
//                                   AutoSizeText(
//                                     "26985 Brighton Lane, Lake Forest, CA 92630.",
//                                     minFontSize: 8,
//                                     maxLines: 1,
//                                     style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff5C5C5C)),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         InkWell(
//                             onTap: () {
//                               // Navigator.pushNamed(context, Routes.addNewAddressScreen,
//                               //     arguments: UpdateAddressRequest(
//                               //       addressId:addressesCubit.addressesData[index].id.toString() ,
//                               //       addressDetails:addressesCubit.addressesData[index].address.toString() ,
//                               //       latitude: addressesCubit.addressesData[index].latitude.toString(),
//                               //       longitude:  addressesCubit.addressesData[index].longitude.toString(),
//                               //       title:  addressesCubit.addressesData[index].title.toString(),));
//                             },
//                             child: SvgPicture.asset(Images.edit))
//                       ],
//                     ),
//                   )),
//             );
//           },
//           separatorBuilder: (context, index) {
//             return SizedBox(
//               height: 10,
//             );
//           },
//           itemCount: 3),
//       SizedBox(height: 50,),
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 60.0),
//         child: DefaultButton(
//           height: 50,
//           onTap: (){
//             navigateTo(context, AddNewAddressScreen());
//           },
//           text: tr('Add_New_Address'),
//         ),
//       ),
//     ],
//   );
// }
