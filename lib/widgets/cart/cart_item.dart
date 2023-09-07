import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/models/cart_model.dart';
import 'package:on_fast/shared/images/images.dart';

import '../../shared/styles/colors.dart';
import '../item_shared/image_net.dart';

class CartItem extends StatelessWidget {
  CartItem(this.data);

  Cart data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 135,width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(27),
              color: Colors.grey.shade300
          ),
        ),
        Slidable(
          direction: Axis.horizontal,
          endActionPane: ActionPane(
            extentRatio: 0.12,
            motion: ConditionalBuilder(
              condition: FastCubit.get(context).cartId != data.id,
              fallback: (c)=>CupertinoActivityIndicator(),
              builder: (c)=> InkWell(
                onTap: (){
                  FastCubit.get(context).deleteCart(cartId: data.id??'');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadiusDirectional.only(
                      topEnd: Radius.circular(27),
                      bottomEnd: Radius.circular(27),
                    ),
                    color: Colors.grey.shade300,
                  ),
                  padding: EdgeInsetsDirectional.all(14),
                  child: Image.asset(Images.bin,width: 20,height: 20,),
                ),
              ),
            ),
            children: const[],
          ),
          child:Container(
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
                  child: ImageNet(image: data.productImage??'',fit: BoxFit.cover,),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.productTitle??'',
                          maxLines: 1,
                          style: TextStyle(fontSize: 16),
                        ),
                        if(data.extras!.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:data.extras!.map((e) => Text(
                              '${e.selectedExtraName??''} , ',
                              maxLines: 1,
                              style: TextStyle(fontSize: 12),
                            ),).toList(),
                          ),
                        ),
                        Text(
                          '${data.productPrice??'0'} AED',
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
                        ),
                        Container(
                          height: 34,width: 96,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(58),
                            color: defaultColor.withOpacity(.3)
                          ),
                          padding:const EdgeInsets.symmetric(horizontal: 15),
                          child: ConditionalBuilder(
                            condition: FastCubit.get(context).cartId != data.id,
                            fallback: (c)=>const CupertinoActivityIndicator(),
                            builder: (c)=> Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    int quantity = data.quantity! +1;
                                    FastCubit.get(context).updateCart(
                                        productId: data.id??'',
                                        quantity: quantity
                                    );
                                  },
                                  child: const Text(
                                    '+',
                                    style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  '${ data.quantity??''}',
                                  style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500),
                                ),
                                InkWell(
                                  onTap: (){
                                    int quantity = data.quantity! -1;
                                    FastCubit.get(context).updateCart(
                                        productId: data.id??'',
                                        quantity: quantity
                                    );
                                  },
                                  child: const Text(
                                    '-',
                                    style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
