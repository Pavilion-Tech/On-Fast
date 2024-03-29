import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/cubit/states.dart';
import 'package:on_fast/modules/product/data/response/product_details_response.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';
import '../../models/provider_products_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/components/uti.dart';
import '../../shared/styles/colors.dart';
import '../../widgets/item_shared/default_button.dart';
import '../../widgets/item_shared/image_net.dart';
import '../../widgets/product/extra.dart';
import '../../widgets/product/select_size.dart';
import '../../widgets/product/select_type.dart';
import '../../widgets/shimmer/notification_shimmer.dart';
import 'cubit/product_cubit/product_cubit.dart';
import 'cubit/product_cubit/product_state.dart';

class ProductScreen extends StatefulWidget {

  ProductScreen({this.productData, this.isClosed, this.id});

    ProductData? productData;
   bool? isClosed;
 final String? id;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late SelectSize selectSize;

  late SelectType selectType;

  late ExtraWidget extraWidget;

  int quantity=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     if(widget.id !=null){
       print("widget.id ");
       print(widget.id );
       ProductCubit.get(context).productDetails=ProductData();
       ProductCubit.get(context).getProductDetails(id: widget.id.toString());
     }else{
       print(" no widget.id ");
       print(widget.productData?.sizes?.first.name??"");
       selectSize = SelectSize(widget.productData?.sizes??[]);
       selectType = SelectType(widget.productData?.types??[]);
       extraWidget = ExtraWidget(widget.productData?.extras??[]);
     }

  }
  @override
  Widget build(BuildContext context) {



    return BlocConsumer<FastCubit, FastStates>(
  listener: (context, state) {

  },
  builder: (context, state) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(''),
          BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {

            },
            builder: (context, state) {
              var addressesCubit = ProductCubit.get(context);
              if ( state is ProductLoadState) {
                return const NotificationShimmer();
                // return Center(child: UTI.loadingWidget(),);
              }
              if (addressesCubit.productDetails==null&& state is ProductSuccessState) {
                return UTI.dataEmptyWidget(noData:  tr("noDataFounded"), imageName: Images.productNotFound);
              }
              if (state is ProductErrorState) {
                return UTI.dataEmptyWidget(noData:  tr("noDataFounded"), imageName: Images.productNotFound);
              }
              if(widget.id!=null){
                selectSize = SelectSize(addressesCubit.productDetails?.sizes??[]);
                print("addressesCubit.productDetails?.types");
                print(addressesCubit.productDetails?.types?.first.name??"");
                selectType = SelectType(addressesCubit.productDetails?.types??[]);
                extraWidget = ExtraWidget(addressesCubit.productDetails?.extras??[]);
              }

              return  Expanded(
                child: SingleChildScrollView(
                  child: body( context,productData:widget.id==null? widget.productData!:addressesCubit.productDetails!),
                ),
              );
            },

          )
        ],
      ),
    );
  },
);
  }

  Widget body(  BuildContext context,{required ProductData productData}) {
    return Column(
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
                            child: ImageNet(image:widget.productData?.mainImage??''),
                          ),
                          AutoSizeText(
                            productData.title??'',
                            minFontSize: 8,
                            maxLines: 1,
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
                          AutoSizeText(
                            tr('description'),
                            minFontSize: 8,
                            maxLines: 1,
                            style:const TextStyle(fontSize: 16),
                          ),
                          AutoSizeText(
                            productData.description??'',
                            minFontSize: 8,
                            maxLines: 1,
                            style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w300,color: Colors.grey),
                          ),
                          if(productData.sizes?.isNotEmpty??true)
                          // if(productData?.sizes!.length != 1 &&productData?.sizes![0].name!='')
                            Padding(
                              padding: const EdgeInsets.only(top: 30,bottom: 10),
                              child: AutoSizeText(
                                tr('select_size'),
                                minFontSize: 8,
                                maxLines: 1,
                                style:const TextStyle(fontSize: 16),
                              ),
                            ),
                          if(productData.sizes?.isNotEmpty??true)
                          // if(productData?.sizes!.length != 1 &&productData?.sizes![0].name!='')
                            selectSize,
                          if(productData.types?.typesWithoutNulls().isNotEmpty??true)
                          // if(productData?.types!.length != 1 &&productData?.types![0].name!='')
                            Padding(
                              padding: const EdgeInsets.only(top: 30,bottom: 10),
                              child: AutoSizeText(
                                tr('select_type'),
                                minFontSize: 8,
                                maxLines: 1,
                                style:const TextStyle(fontSize: 16),
                              ),
                            ),
                          if(productData.types?.typesWithoutNulls().isNotEmpty??true)
                          // if(productData?.types!.length != 1 &&productData?.types![0].name!='')
                            selectType,
                          if(productData.extras?.withoutNulls().isNotEmpty??true)
                            Padding(
                              padding: const EdgeInsets.only(top: 30,bottom: 10),
                              child: AutoSizeText(
                                tr('extra'),
                                minFontSize: 8,
                                maxLines: 1,
                                style:const TextStyle(fontSize: 16),
                              ),
                            ),
                          if(productData.extras?.withoutNulls().isNotEmpty??true)
                          // if(productData?.extras!.length != 1 &&productData?.extras![0].name!='')
                            extraWidget,
                        ],
                      ),
                    ),

                    BlocConsumer<FastCubit, FastStates>(
                      listener: (context, state) {

                      },
                      builder: (context, state) {
                        return ConditionalBuilder(
                          condition: state is! AddToCartLoadingState,
                          fallback: (c)=>Center(child: CupertinoActivityIndicator(),),
                          builder: (c)=>InkWell(
                            onTap: () {
                             if( widget.id !=null){
                               print("productData.opeingStatus");
                               print(productData.providerId?.opeingStatus);
                                widget.isClosed=productData.providerId?.opeingStatus=="close";
                              }

                              if( widget.isClosed??false){
                                showToast(msg: tr('restaurant_closed'));
                              }else{
                                FastCubit.get(context).addToCart(
                                    context: context,
                                    quantity: quantity.toString(),
                                    productId: productData.id??'',
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
                                  AutoSizeText(
                                    tr('add_to_cart'),
                                    minFontSize: 8,
                                    maxLines: 1,
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
                                            FastCubit.get(context).emitState();
                                          },
                                          child: Container(
                                            height: 34,width: 34,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                            ),
                                            child: Center(
                                              child: const AutoSizeText(
                                                '+',
                                                minFontSize: 8,
                                                maxLines: 1,
                                                style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500,color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8,),
                                        AutoSizeText(
                                          '${  quantity??''}',
                                          minFontSize: 8,
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500,color: Colors.white),
                                        ),
                                        SizedBox(width: 8,),
                                        InkWell(
                                          onTap: (){
                                            if(quantity>1)
                                              quantity--;
                                            FastCubit.get(context).emitState();
                                          },
                                          child:Container(
                                            height: 34,width: 34,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:Color(0xffCACACA)
                                            ),
                                            child: Center(
                                              child: const AutoSizeText(
                                                '-',
                                                minFontSize: 8,
                                                maxLines: 1,
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



                        );
                      },

                    ),
                    const SizedBox(height: 40,),
                  ],
                );
  }
}
