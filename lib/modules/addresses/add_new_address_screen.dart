
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_fast/shared/images/images.dart';

import '../../shared/components/components.dart';
import '../../widgets/item_shared/Text_form.dart';
import '../../widgets/item_shared/default_appbar.dart';
import '../../widgets/item_shared/default_button.dart';
import 'address_details_on_map_screen.dart';




class AddNewAddressScreen extends StatefulWidget {
  // final UpdateAddressRequest? updateAddressRequest;
  // const AddNewAddressScreen({Key? key, this.updateAddressRequest}) : super(key: key);
  const AddNewAddressScreen({Key? key,  }) : super(key: key);

  @override
  State<AddNewAddressScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<AddNewAddressScreen> {

 
  @override
  void initState() {
    super.initState();

    // if(widget.updateAddressRequest?.latitude !=null){
    //   titleController.text=widget.updateAddressRequest?.title??"";
    //   AddressCubit.get(context).addressDetailsController.text=widget.updateAddressRequest?.addressDetails??"";
    // }else{
    //   AddressCubit.get(context).addressDetailsController.clear();
    // }



  }
  var formKey=GlobalKey<FormState>();
  var titleController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.locale;

    return Scaffold(


      body: Form(
        key: formKey,
        child: Column(
          children: [
            DefaultAppBar(tr('Add_New_Address')),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        addressesText(),
                        const SizedBox(height: 20,),
                        InputTextFormField(


                          paddingHorizontal: 0,
                            paddingVertical: 0,
                            suffixIcon:   Padding(
                              padding: const EdgeInsets.all(12.0),

                            ),
                            fillColor: Colors.white,

                            hintText:tr("Address_Name"),
                            textEditingController: titleController,

                            validator: (val) {
                              if (val.isEmpty) {
                                return tr("Address_Name_can_not_be_empty");
                              }
                            },


                            textInputType: TextInputType.text,
                            inputAction: TextInputAction.done),
                        const SizedBox(height: 20,),
                        InputTextFormField(
                          paddingHorizontal: 0,
                            paddingVertical: 0,
                            onTap: (){
                            // if(widget.updateAddressRequest?.latitude !=null){
                            //   Navigator.pushNamed(context, Routes.addressDetailsOnMapScreen,
                            //  arguments: UpdateAddressRequest(
                            //       addressDetails:widget.updateAddressRequest?.addressDetails.toString() ,
                            //   latitude: widget.updateAddressRequest?.latitude.toString(),
                            //   longitude:  widget.updateAddressRequest?.longitude.toString(),
                            //   title:  widget.updateAddressRequest?.title.toString(),)
                            //   );
                            //
                            //
                            // }
                            // else{
                            //   Navigator.pushNamed(context, Routes.addressDetailsOnMapScreen,
                            //       arguments: UpdateAddressRequest()
                            //   );
                            // }
                              navigateTo(context, AddressDetailsOnMapScreen());

                            },
                            readOnly: true,
                            suffixIcon:   Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(Images.location1,),
                            ),
                            fillColor: Colors.white,
                            hintText:tr("Address_Details"),
                            // textEditingController: AddressCubit.get(context).addressDetailsController,
                            textEditingController: TextEditingController(),

                            validator: (val) {
                              if (val.isEmpty) {
                                return tr("Address_Details_can_not_be_empty");
                              }
                            },


                            textInputType: TextInputType.text,
                            inputAction: TextInputAction.done),
                        const SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60.0),
                          child: DefaultButton(
                            height: 50,
                            onTap: (){

                            },
                            text: tr('Save'),
                          ),
                        ),
                        // BlocConsumer<AddressCubit, AddressState>(
                        //   listener: (context, state) {
                        //
                        //
                        //   },
                        //   builder: (context, state) {
                        //     return
                        //       state is AddOrUpdateAddressLoadState?
                        //
                        //       Center(child: CircularProgressIndicator(color: AppColors.primary,),):
                        //       CustomButton(text: LocaleKeys.Save.tr(),
                        //         margin: 0,
                        //         onTap: () {
                        //           if(formKey.currentState!.validate()){
                        //             if(widget.updateAddressRequest?.latitude !=null){
                        //
                        //               UpdateAddressRequest  updateAddressRequest=UpdateAddressRequest(
                        //                   latitude: AddressCubit.get(context).lat??widget.updateAddressRequest?.latitude,
                        //                   title: titleController.text,
                        //                   longitude:AddressCubit.get(context).lang??widget.updateAddressRequest?.longitude);
                        //               AddressCubit.get(context).updateAddress(
                        //                   context: context,
                        //                   updateAddressRequest:updateAddressRequest ,
                        //                    addressId: widget.updateAddressRequest?.addressId??""
                        //               );
                        //
                        //             }else{
                        //               AddAddressRequest  addAddressRequest=AddAddressRequest(latitude:
                        //               AddressCubit.get(context).lat??'',
                        //                   title: titleController.text,longitude:AddressCubit.get(context).lang??'');
                        //               AddressCubit.get(context).addAddress(
                        //                   context: context,
                        //                   addAddressRequest:addAddressRequest
                        //               );
                        //
                        //             }
                        //
                        //
                        //
                        //           }
                        //
                        //         },);
                        //   },
                        //
                        // ),

                        ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),

    );
  }



  Row addressesText() {
    return Row(
      children: [
        // Text(widget.updateAddressRequest?.latitude !=null?LocaleKeys.Edit_Address.tr():LocaleKeys.Add_New_Address.tr(),style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Color(0xff5C5C5C)),),
        Text(tr("Add_New_Address"),style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Color(0xff5C5C5C)),),

      ],
    );
  }

}