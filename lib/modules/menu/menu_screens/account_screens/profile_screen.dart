import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';
import 'package:on_fast/widgets/item_shared/defult_form.dart';
import 'package:on_fast/widgets/item_shared/phone_form.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(tr('profile_info')),
          Padding(
            padding: const EdgeInsets.all(20.0),
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
                    hint: tr('email_address'),
                    type: TextInputType.emailAddress,
                    prefix: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(Images.mail,width: 10,),
                    ),
                  ),
                ),
                PhoneForm(),
                const SizedBox(height: 30,),
                DefaultButton(text: tr('save_info'), onTap: ()=>Navigator.pop(context))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
