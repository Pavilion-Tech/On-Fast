import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/states.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:on_fast/widgets/home/app_bar.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/components/constant.dart';
import '../../widgets/item_shared/category_widget.dart';
import '../../widgets/item_shared/provider_item.dart';
import '../../widgets/shimmer/default_list_shimmer.dart';
import '../../widgets/shimmer/home_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool closeTop = false;
  ScrollController gridController = ScrollController();

  @override
  void initState() {
    gridController.addListener(() {
      setState(() {
        closeTop =  gridController.offset>100;
      });
    });
    super.initState();
  }


  @override
  void dispose() {
    gridController.removeListener(() { });
    gridController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit, FastStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = FastCubit.get(context);
    return ConditionalBuilder(
      condition:cubit.adsModel!=null&&cubit.categoriesModel!=null&&cubit.providerCategoryModel!=null,
      fallback: (c)=>HomeShimmer(),
      builder: (c)=> SafeArea(
        child: Column(
          children: [
            HomeAppBar(closeTop),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CategoryWidget(data: cubit.categoriesModel!.data),
            ),
            Expanded(
                child: ConditionalBuilder(
                  condition: state is! ProviderCategoryLoadingState,
                  fallback: (c)=>DefaultListShimmer(),
                  builder: (c)=> ConditionalBuilder(
                    condition: cubit.providerCategoryModel!.data!.data!.isNotEmpty,
                    fallback: (c)=>Center(child:Text(tr('no_restaurant'))),
                    builder: (c){
                      Future.delayed(Duration.zero,(){
                        cubit.paginationProviderCategory(gridController);
                      });
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (c,i)=>ProviderItem(providerData: cubit.providerCategoryModel!.data!.data![i]),
                              separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                              itemCount: cubit.providerCategoryModel!.data!.data!.length,
                              controller: gridController,
                              padding:const EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                          if(state is ProviderCategoryLoadingState)
                            CupertinoActivityIndicator()
                        ],
                      );
                    }
                  ),
                )
            )
          ],
        ),
      ),
    );
  },
);
  }
}
