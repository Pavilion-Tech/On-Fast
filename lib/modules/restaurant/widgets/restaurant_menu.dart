import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/cubit/states.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/widgets/item_shared/category_widget.dart';
import 'package:on_fast/widgets/restaurant/product.dart';
import 'package:on_fast/widgets/shimmer/default_list_shimmer.dart';

class RestaurantMenu extends StatelessWidget {
  const RestaurantMenu({
    super.key,
    required this.cubit,
  });

  final FastCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit,FastStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:cubit.singleProviderModel?.data?.childCategoriesModified?.isNotEmpty??true,
          fallback: (c)=>Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Images.splashImage,width: 200,),
                  AutoSizeText(tr('no_products'), minFontSize: 8,
                    maxLines: 1,),
                ],
              )),
          builder: (c)=> ConditionalBuilder(
            condition: cubit.productsModel!=null,
            fallback: (c)=>Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: DefaultListShimmer(),
            ),
            builder: (c)=> Column(
              children: [
                Padding(
                  padding:EdgeInsetsDirectional.only(top: 0,start: 20),
                  child: CategoryWidget(data: cubit.singleProviderModel?.data?.childCategoriesModified,isRestaurant: true),
                ),
                ConditionalBuilder(
                    condition: cubit.productsModel!.data!.data!.isNotEmpty,
                    fallback: (c)=>Expanded(child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Images.splashImage,width: 200,),
                            AutoSizeText(tr('no_products'), minFontSize: 8,
                              maxLines: 1,),
                          ],
                        ))),
                    builder: (c){
                      Future.delayed(Duration.zero, () {
                        cubit.paginationProviderProducts();
                      });
                      return Expanded(
                        child: Column(
                          children: [
                            Expanded(
                                child: ListView.separated(

                                  itemBuilder: (c,i)=>Product(
                                      cubit.productsModel!.data!.data![i],
                                      cubit.singleProviderModel!.data!.openStatus == 'open'?false:true
                                  ),
                                  separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                                  itemCount: cubit.productsModel!.data!.data!.length,
                                  controller:cubit.productsScrollController,
                                  padding: EdgeInsets.only(top: 20,right: 20,left: 20,),
                                )
                            ),
                            if (state is ProviderProductsLoadingState)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 40.0),
                                child: CupertinoActivityIndicator(),
                              ),
                          ],
                        ),
                      );
                    }
                )
              ],
            ),
          ),
        );
      },

    );
  }
}