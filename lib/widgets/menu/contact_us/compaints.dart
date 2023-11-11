import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_fast/modules/menu/cubit/menu_states.dart';

import '../../../modules/menu/cubit/menu_cubit.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';
import '../../item_shared/default_button.dart';
import '../../item_shared/defult_form.dart';
import '../../item_shared/phone_form.dart';

class Compaints extends StatelessWidget {
  Compaints({Key? key}) : super(key: key);

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController subjectC = TextEditingController();
  TextEditingController messageC = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = MenuCubit.get(context);
    if (cubit.userModel != null) {
      nameC.text = cubit.userModel!.data!.name ?? '';
      emailC.text = cubit.userModel!.data!.email ?? '';
      phoneC.text = cubit.userModel!.data!.phoneNumber ?? '';
    }
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {
        if(state is ContactUsSuccessState)Navigator.pop(context);
      },
      builder: (context, state) {
        return InkWell(
          onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(Images.gmail),
                          SvgPicture.asset(Images.twitter),
                          SvgPicture.asset(Images.whatsUp),
                          SvgPicture.asset(Images.instgram),
                          SvgPicture.asset(Images.facebook),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    DefaultForm(
                      hint: tr('full_name'),
                      controller: nameC,
                      validator: (str) {
                        if (str.isEmpty) return tr('name_empty');
                        return null;
                      },
                      prefix: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(Images.user, width: 10,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: DefaultForm(
                        controller: emailC,
                        hint: tr('email_address'),
                        prefix: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(Images.mail, width: 10,),
                        ),
                      ),
                    ),
                    PhoneForm(
                      controller: phoneC,
                      validator: (str) {
                        if (str.isEmpty) return tr('phone_empty');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: DefaultForm(
                        hint: tr('subject'),
                        controller: subjectC,
                        validator: (str) {
                          if (str.isEmpty) return tr('subject_empty');
                        },
                      ),
                    ),
                    TextFormField(
                      maxLines: 3,
                      controller: messageC,
                      validator: (str) {
                        if (str!.isEmpty) return tr('message_empty');
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius
                                  .circular(15)),
                              borderSide: BorderSide(color: defaultColor)
                          ),
                          hintText: tr('want_to'),
                          hintStyle: const TextStyle(color: Colors.grey)
                      ),
                    ),
                    const SizedBox(height: 30,),
                    ConditionalBuilder(
                      condition: state is! ContactUsLoadingState,
                      fallback: (c)=>const Center(child: CupertinoActivityIndicator(),),
                      builder: (c)=> DefaultButton(
                          text: tr('send'),
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              cubit.contactUs(
                                  subject: subjectC.text,
                                  message: messageC.text
                              );
                            }
                          }
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
