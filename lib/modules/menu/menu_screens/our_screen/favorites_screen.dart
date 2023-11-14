import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/modules/home/cubits/home_category_cubit/home_category_cubit.dart';
import 'package:on_fast/widgets/item_shared/default_appbar.dart';

import '../../../../layout/cubit/states.dart';
import '../../../../widgets/item_shared/provider_item.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  ScrollController gridController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FastCubit, FastStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = FastCubit.get(context);
          return Column(
            children: [
              DefaultAppBar(tr('Favorites')),
              SizedBox(height: 20,),
              Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (c,i)=>ProviderItem(providerData: HomeCategoryCubit.get(context).providerCategoryModel!.data!.data![i]),
                    separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                    itemCount: HomeCategoryCubit.get(context).providerCategoryModel!.data!.data!.take(2).length,
                    controller: gridController,

                    padding:const EdgeInsets.symmetric(horizontal: 20),
                  ),

                ],
              ),
            ],
          );
        },

      ),
    );
  }
}
