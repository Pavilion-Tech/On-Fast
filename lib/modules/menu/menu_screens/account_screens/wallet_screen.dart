import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(tr('wallet')),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Image.asset(Images.wallet,width: size!.width*.6,),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 30.0),
                //   child:Text.rich(
                //       TextSpan(
                //           text: '2.589',
                //           style: TextStyle(color: defaultColor,fontWeight: FontWeight.w600,fontSize: 35),
                //           children: [
                //             TextSpan(
                //               text: 'SAR',
                //               style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,fontSize: 11),
                //             )
                //           ]
                //       )
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child:Column(
                    children: [
                      Text(
                        tr('opps'),
                        style: TextStyle(color: defaultColor,fontWeight: FontWeight.w600,fontSize: 35),
                      ),
                      Text(
                        tr('no_payments'),
                        style:const TextStyle(color: Colors.black54,fontWeight: FontWeight.w400,fontSize: 13),
                      ),
                      Text(
                        tr('look_like'),
                        textAlign: TextAlign.center,
                        style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15,height: 1),
                      ),
                      const SizedBox(height: 30,),
                      DefaultButton(
                          text: tr('continue_shopping'),
                          onTap: (){
                            FastCubit.get(context).changeIndex(0);
                            Navigator.pop(context);
                          }),
                    ],
                  )
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
