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
import '../../widgets/item_shared/default_button.dart';
import '../../widgets/item_shared/image_net.dart';
import '../../widgets/product/extra.dart';
import '../../widgets/product/select_size.dart';
import '../../widgets/product/select_type.dart';

class ProductScreen extends StatelessWidget {

  ProductScreen(this.productData,this.isClosed);

  ProductData productData;
  late SelectSize selectSize;
  late SelectType selectType;
  late ExtraWidget extraWidget;
  bool isClosed;



  @override
  Widget build(BuildContext context) {

    selectSize = SelectSize(productData.sizes!);
    selectType = SelectType(productData.types!);
    extraWidget = ExtraWidget(productData.extras!);

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
                          child: ImageNet(image:productData.mainImage??''),
                        ),
                        Text(
                          productData.title??'',
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
                          productData.description??'',
                          style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w300,color: Colors.grey),
                        ),
                        if(productData.sizes!.isNotEmpty)
                          if(productData.sizes!.length != 1 &&productData.sizes![0].name!='')
                            Padding(
                            padding: const EdgeInsets.only(top: 30,bottom: 10),
                          child: Text(
                            tr('select_size'),
                            style:const TextStyle(fontSize: 16),
                          ),
                        ),
                        if(productData.sizes?.isNotEmpty??true)
                          if(productData.sizes!.length != 1 &&productData.sizes![0].name!='')
                            selectSize,
                        if(productData.types?.isNotEmpty??true)
                          if(productData.types!.length != 1 &&productData.types![0].name!='')
                            Padding(
                          padding: const EdgeInsets.only(top: 30,bottom: 10),
                          child: Text(
                            tr('select_type'),
                            style:const TextStyle(fontSize: 16),
                          ),
                        ),
                        if(productData.types?.isNotEmpty??true)
                          if(productData.types!.length != 1 &&productData.types![0].name!='')
                            selectType,
                        if(productData.extras!.isNotEmpty)
                          if(productData.extras!.length != 1 &&productData.extras![0].name!='')
                            Padding(
                          padding: const EdgeInsets.only(top: 30,bottom: 10),
                          child: Text(
                            tr('extra'),
                            style:const TextStyle(fontSize: 16),
                          ),
                        ),
                        if(productData.extras!.isNotEmpty)
                          if(productData.extras!.length != 1 &&productData.extras![0].name!='')
                            extraWidget,
                      ],
                    ),
                  ),
                  ConditionalBuilder(
                    condition: state is! AddToCartLoadingState,
                    fallback: (c)=>Center(child: CupertinoActivityIndicator(),),
                    builder: (c)=> DefaultButton(
                      text:tr('add_to_cart'),
                      onTap: (){
                        if(!isClosed){
                          showToast(msg: tr('restaurant_closed'));
                        }else{
                          FastCubit.get(context).addToCart(
                              context: context,
                              productId: productData.id??'',
                              selectedSizeId: selectSize.sizedId,
                              extras: extraWidget.extraId,
                              typeId: selectType.typeId
                          );
                        }
                      },
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
