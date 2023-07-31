import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/splash_screen.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';
import 'package:share/share.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../widgets/menu/delete_account_dialog.dart';
import '../../widgets/menu/lang_dialog.dart';
import '../../widgets/menu/menu_appbar.dart';
import 'menu_screens/account_screens/notification_screen.dart';
import 'menu_screens/account_screens/order/order_history_screen.dart';
import 'menu_screens/account_screens/profile_screen.dart';
import 'menu_screens/account_screens/wallet_screen.dart';
import 'menu_screens/our_screen/contact_screen.dart';
import 'menu_screens/our_screen/terms_aboutus_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MenuAppBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Center(
                       child: Text(
                         tr('account_settings'),
                         style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
                       ),
                     ),
                     itemBuilder(
                         title: tr('profile_info'),
                         onPressed: (){
                           navigateTo(context, ProfileScreen());
                         }
                     ), itemBuilder(
                         title:tr('orders_history'),
                         onPressed: (){
                           navigateTo(context, OrderHistoryScreen());
                         }
                     ), itemBuilder(
                         title: tr('wallet'),
                         onPressed: (){
                           navigateTo(context, WalletScreen());
                         }
                     ), itemBuilder(
                         title: tr('notifications'),
                         onPressed: (){
                           navigateTo(context, NotificationScreen());
                         }
                     ),
                   ],
                 ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Center(
                       child: Text(
                         tr('our_app'),
                         style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
                       ),
                     ),
                     itemBuilder(
                         title: tr('languages'),
                         onPressed: (){
                           showDialog(
                               context: context,
                               builder: (context)=>LangDialog()
                           );
                         }
                     ), itemBuilder(
                         title: tr('contact_us'),
                         onPressed: (){
                           navigateTo(context, ContactScreen());
                         }
                     ), itemBuilder(
                         title: tr('about_us'),
                         onPressed: (){
                           navigateTo(context, TermsAboutUsScreen('about_us'));
                         }
                     ),itemBuilder(
                         title: tr('terms'),
                         onPressed: (){
                           navigateTo(context, TermsAboutUsScreen('terms'));
                         }
                     ),itemBuilder(
                         title: tr('share_app'),
                         onPressed: () async{
                           Share.share('Hello');

                         }
                     ),itemBuilder(
                         title: '${tr('version')} 1.0',
                     ),
                     TextButton(
                       onPressed: (){
                         openUrl('https://www.pavillionteck.com/');
                       },
                       child: Row(
                         children: [
                           Text(
                             tr('powered_by'),
                             style:const TextStyle(color: Colors.black,fontSize: 16.4),
                           ),
                           const SizedBox(width: 10,),
                           Image.asset(Images.pavilion,width: 20,)
                         ],
                       ),
                     ),
                     Center(child: DefaultButton(
                         text: tr('logout'),
                         onTap: (){
                           token = null;
                           navigateAndFinish(context, SplashScreen());
                         })
                     ),
                     Center(
                       child: TextButton(
                         onPressed: (){
                           showDialog(
                               context: context,
                               builder: (context)=>DeleteAccountDialog()
                           );
                         },
                         child: Text(
                           tr('delete_account'),
                           style: TextStyle(color: defaultColor),
                         ),
                       ),
                     ),
                   ],
                 ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget itemBuilder({required String title,VoidCallback? onPressed}){
    return TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style:const TextStyle(color: Colors.black,fontSize: 16.4),
        ),
    );
  }
}
