import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/components/components.dart';
import 'package:on_fast/widgets/cart/cart_item.dart';
import 'package:on_fast/widgets/item_shared/default_button.dart';
import '../../widgets/cart/no_carts.dart';
import '../../widgets/item_shared/default_appbar.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            DefaultAppBar(tr('cart'),isCart: true),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (c, i) => CartItem(),
                  separatorBuilder: (c, i) => const SizedBox(
                        height: 20,
                      ),
                  padding: EdgeInsetsDirectional.only(
                    top: 20,bottom: 70,start: 20,end: 20
                  ),
                  itemCount: 5),
            ),
          ],
        ),
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: DefaultButton(
              text: tr('checkout'),
              onTap: () {
                navigateTo(context, CheckoutScreen());
              },
            ),
          ),
        ),
        // NoCarts(),
      ],
    );
  }
}
