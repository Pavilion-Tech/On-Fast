import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';
import '../../item_shared/default_button.dart';
import '../../item_shared/defult_form.dart';
import '../../item_shared/phone_form.dart';

class Compaints extends StatelessWidget {
  const Compaints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            DefaultForm(
              hint: tr('full_name'),
              prefix: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(Images.user,width: 10,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: DefaultForm(
                hint:tr('email_address'),
                prefix: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(Images.mail,width: 10,),
                ),
              ),
            ),
            PhoneForm(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: DefaultForm(hint: tr('subject')),
            ),
            TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                  contentPadding:const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                  border:const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:const BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: defaultColor)
                  ),
                  hintText: tr('want_to'),hintStyle:const TextStyle(color: Colors.grey)
              ),
            ),
            const SizedBox(height: 30,),
            DefaultButton(text: tr('send'), onTap: ()=>Navigator.pop(context))
          ],
        ),
      ),
    );
  }
}
