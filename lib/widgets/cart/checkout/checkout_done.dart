import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/layout_screen.dart';
import 'package:on_fast/shared/components/components.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';

class CheckoutDone extends StatelessWidget {
  const CheckoutDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding:const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20)),
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
        child: InkWell(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: () => Navigator.pop(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Images.checkoutDialog,
                width: 200,
              ),
              Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: tr('congratulations'),
                      style:const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                      children: [
                        TextSpan(
                            text: tr('order_success'),
                            style:const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                            children: [
                              TextSpan(
                                  text: '22335566',
                                  style: TextStyle(
                                      color: defaultColor,fontWeight:FontWeight.w700, fontSize: 15
                                  )),
                            ]),
                      ])),
              const SizedBox(height: 20,),
              DefaultButton(
                  text: tr('continue_shopping'),
                  onTap: () {
                    FastCubit.get(context).changeIndex(0);
                    navigateAndFinish(context, FastLayout());
                  }),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    tr('order_details'),
                    style: TextStyle(
                        color: defaultColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
