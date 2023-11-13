import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/cubit/states.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';
import '../../models/provider_products_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/styles/colors.dart';
import '../../widgets/item_shared/default_button.dart';
import '../../widgets/item_shared/image_net.dart';
import '../../widgets/product/extra.dart';
import '../../widgets/product/select_size.dart';
import '../../widgets/product/select_type.dart';

class ProductScreen extends StatefulWidget {

  ProductScreen(this.productData,this.isClosed);

  ProductData productData;
  bool isClosed;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late SelectSize selectSize;

  late SelectType selectType;

  late ExtraWidget extraWidget;

  int quantity=1;

  @override
  Widget build(BuildContext context) {

    selectSize = SelectSize(widget.productData.sizes!);
    selectType = SelectType(widget.productData.types!);
    extraWidget = ExtraWidget(widget.productData.extras!);

    return BlocConsumer<FastCubit, FastStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(''),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Container(
                          height: 258,width: 258,
                          decoration:const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: ImageNet(image:widget.productData.mainImage??''),
                        ),
                        Text(
                          widget.productData.title??'',
                          textAlign: TextAlign.center,
                          style:const TextStyle(fontSize: 35,fontWeight: FontWeight.w500,height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('description'),
                          style:const TextStyle(fontSize: 16),
                        ),
                        Text(
                          widget.productData.description??'',
                          style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w300,color: Colors.grey),
                        ),
                        if(widget.productData.sizes!.isNotEmpty)
                          if(widget.productData.sizes!.length != 1 &&widget.productData.sizes![0].name!='')
                            Padding(
                            padding: const EdgeInsets.only(top: 30,bottom: 10),
                          child: Text(
                            tr('select_size'),
                            style:const TextStyle(fontSize: 16),
                          ),
                        ),
                        if(widget.productData.sizes?.isNotEmpty??true)
                          if(widget.productData.sizes!.length != 1 &&widget.productData.sizes![0].name!='')
                            selectSize,
                        if(widget.productData.types?.isNotEmpty??true)
                          if(widget.productData.types!.length != 1 &&widget.productData.types![0].name!='')
                            Padding(
                          padding: const EdgeInsets.only(top: 30,bottom: 10),
                          child: Text(
                            tr('select_type'),
                            style:const TextStyle(fontSize: 16),
                          ),
                        ),
                        if(widget.productData.types?.isNotEmpty??true)
                          if(widget.productData.types!.length != 1 &&widget.productData.types![0].name!='')
                            selectType,
                        if(widget.productData.extras!.isNotEmpty)
                          if(widget.productData.extras!.length != 1 &&widget.productData.extras![0].name!='')
                            Padding(
                          padding: const EdgeInsets.only(top: 30,bottom: 10),
                          child: Text(
                            tr('extra'),
                            style:const TextStyle(fontSize: 16),
                          ),
                        ),
                        if(widget.productData.extras!.isNotEmpty)
                          if(widget.productData.extras!.length != 1 &&widget.productData.extras![0].name!='')
                            extraWidget,
                      ],
                    ),
                  ),

                  ConditionalBuilder(
                    condition: state is! AddToCartLoadingState,
                    fallback: (c)=>Center(child: CupertinoActivityIndicator(),),
                    builder: (c)=>InkWell(
                      onTap: () {
                        if(!widget.isClosed){
                          showToast(msg: tr('restaurant_closed'));
                        }else{
                          FastCubit.get(context).addToCart(
                              context: context,
                              productId: widget.productData.id??'',
                              selectedSizeId: selectSize.sizedId,
                              extras: extraWidget.extraId,
                              typeId: selectType.typeId
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        width:  size!.width*.8,
                        decoration: BoxDecoration(
                            color: defaultColor,
                            borderRadius: BorderRadiusDirectional.circular(5),
                            border: Border.all(color: defaultColor)
                        ),
                        alignment: AlignmentDirectional.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr('add_to_cart'),
                              style: TextStyle(
                                   fontSize: 15,fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              height: 34,width: 130,
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadiusDirectional.circular(58),
                              //   color: defaultColor.withOpacity(.3)
                              // ),
                              padding:const EdgeInsets.symmetric(horizontal: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){

                                        quantity++;
                                       setState(() {

                                       });
                                    },
                                    child: Container(
                                      height: 34,width: 34,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white
                                      ),
                                      child: Center(
                                        child: const Text(
                                          '+',
                                          style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500,color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    '${  quantity??''}',
                                    style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500,color: Colors.white),
                                  ),
                                  SizedBox(width: 8,),
                                  InkWell(
                                    onTap: (){
                                      if(quantity>1)
                                       quantity--;
                                      setState(() {

                                      });
                                    },
                                    child:Container(
                                      height: 34,width: 34,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:Color(0xffCACACA)
                                      ),
                                      child: Center(
                                        child: const Text(
                                          '-',
                                          style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500,color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),



                  ),
                  const SizedBox(height: 40,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  },
);
  }
}
