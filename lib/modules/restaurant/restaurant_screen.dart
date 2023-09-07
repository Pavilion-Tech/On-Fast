import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/cubit/states.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/styles/colors.dart';
import 'package:on_fast/widgets/shimmer/default_list_shimmer.dart';

import '../../models/provider_category_model.dart';
import '../../shared/images/images.dart';
import '../../widgets/item_shared/category_widget.dart';
import '../../widgets/item_shared/provider_item.dart';
import '../../widgets/restaurant/app_bar.dart';
import '../../widgets/restaurant/info.dart';
import '../../widgets/restaurant/product.dart';

class RestaurantScreen extends StatefulWidget {
  RestaurantScreen(this.providerData,{this.isBranch = false});

  ProviderData providerData;
  bool isBranch;


  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen>with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController =  TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit, FastStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = FastCubit.get(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () {
              return Future.delayed(Duration.zero,(){
                FastCubit.get(context).getAllProducts();
              });
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: size!.height,
              child: Column(
                children: [
                  RestaurantAppBar(widget.providerData,widget.isBranch),
                  TabBar(
                    labelColor: Colors.black,
                    indicatorColor: defaultColor,
                    indicatorPadding: EdgeInsets.zero,
                    labelStyle: TextStyle(fontSize: 20),
                    tabs: [
                      Tab(
                        text: tr('menu'),
                      ),
                      Tab(
                        text: tr('info'),
                      )
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                  Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        children: [
                          ConditionalBuilder(
                            condition:widget.providerData.childCategoriesModified!.isNotEmpty,
                            fallback: (c)=>Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(Images.splashImage,width: 200,),
                                    Text(tr('no_products')),
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
                                    padding:EdgeInsetsDirectional.only(top: 20,start: 20),
                                    child: CategoryWidget(data: widget.providerData.childCategoriesModified,isRestaurant: true),
                                  ),
                                  ConditionalBuilder(
                                      condition: cubit.productsModel!.data!.data!.isNotEmpty,
                                      fallback: (c)=>Expanded(child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(Images.splashImage,width: 200,),
                                              Text(tr('no_products')),
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
                                                        widget.providerData.openStatus == 'open'?false:true
                                                    ),
                                                    separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                                                    itemCount: cubit.productsModel!.data!.data!.length,
                                                    controller:cubit.productsScrollController,
                                                    padding: EdgeInsets.only(top: 20,right: 20,left: 20),
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
                          ),
                          Info(widget.providerData)
                        ]
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  },
);
  }
}


