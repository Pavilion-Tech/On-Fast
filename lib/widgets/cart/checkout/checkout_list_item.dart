import 'package:flutter/material.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/models/cart_model.dart';
import 'package:on_fast/shared/styles/colors.dart';
import '../../../models/order_model.dart';
import '../../item_shared/image_net.dart';

class CheckOutListItem extends StatelessWidget {
  const CheckOutListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: FastCubit.get(context).cartModel!.data!.data!.cart!.length == 1?200:470,
      child: ListView.separated(
          itemBuilder: (c,i)=>CheckOutItem(cartData: FastCubit.get(context).cartModel!.data!.data!.cart![i]),
          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
          padding: EdgeInsetsDirectional.all(20),
          itemCount: FastCubit.get(context).cartModel!.data!.data!.cart!.length
      ),
    );
  }
}

class CheckOutItem extends StatelessWidget {
  CheckOutItem({required this.cartData});

  Cart cartData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(27),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 20,
            ),   BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 20,
            ),
          ]
      ),
      child: Row(
        children: [
          Container(
            height: 135,width: 135,
            decoration: BoxDecoration(
              borderRadius:BorderRadiusDirectional.circular(27),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ImageNet(image:cartData?.productImage??'',fit: BoxFit.cover,),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cartData.productTitle??'',
                  style: TextStyle(fontSize: 20),
                ),
                if(cartData.extras!.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:cartData.extras!.map((e) => Text(
                        '${e.selectedExtraName??''} , ',
                        maxLines: 1,
                        style: TextStyle(fontSize: 16),
                      ),).toList(),
                    ),
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${cartData?.quantity??''}',
                      style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.w500,color: defaultColor),
                    ),
                    Text(
                      ' * ',
                      style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${cartData?.productPrice??''} AED',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class OrderItem extends StatelessWidget {
  OrderItem({required this.products});

  Products products;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(27),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 20,
            ),   BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 20,
            ),
          ]
      ),
      child: Row(
        children: [
          Container(
            height: 135,width: 135,
            decoration: BoxDecoration(
              borderRadius:BorderRadiusDirectional.circular(27),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ImageNet(image:products?.image??'',fit: BoxFit.cover,),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  products?.title??'',
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${products?.orderedQuantity??''}',
                      style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.w500,color: defaultColor),
                    ),
                    Text(
                      ' * ',
                      style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${products?.priceAfterDiscount??''} AED',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

