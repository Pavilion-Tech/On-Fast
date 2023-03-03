import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/modules/auth/verification.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';
import 'package:on_fast/widgets/menu/lang_dialog.dart';

import '../../widgets/item_shared/phone_form.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: TextButton(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: Text(
              tr('current_lang'),
              style: TextStyle(color: defaultColor,fontSize: 15),
            ),
          ),
          onPressed: (){
            showDialog(
                context: context,
                builder: (context)=>LangDialog()
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Images.login,
                width: size!.width*.8,height: size!.height*.3,
              ),
              Text(
                tr('hello'),
                style: TextStyle(color:defaultColor,fontWeight: FontWeight.w600,fontSize: 35),
              ),
               Padding(
                padding:const EdgeInsets.only(right: 50,left: 50),
                child: Text(
                  tr('i_happy'),
                  textAlign: TextAlign.center,
                  style:const TextStyle(fontSize: 13),
                ),
              ),
               Padding(
                padding:const  EdgeInsets.symmetric(vertical: 40.0),
                child: PhoneForm(),
              ),
              DefaultButton(
                  text: tr('sign_in'),
                  onTap: (){
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled : true,
                        shape:const RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(50),
                            topStart: Radius.circular(50),
                          )
                        ),
                        builder: (context)=>Verification()
                    );
                  }
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       tr('dont_have_account'),
              //       style: TextStyle(fontSize: 12,color: Colors.grey.shade700),
              //     ),
              //     TextButton(
              //         onPressed: (){},
              //         child:  Text(
              //           tr('sign_up'),
              //           style: TextStyle(fontSize: 12,color: defaultColor,decoration: TextDecoration.underline),
              //         ),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
