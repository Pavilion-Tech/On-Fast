import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/states.dart';
import 'package:on_fast/widgets/home/app_bar.dart';

import '../../layout/cubit/cubit.dart';
import '../../widgets/item_shared/category_widget.dart';
import '../../widgets/item_shared/product_item.dart';

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
    return SafeArea(
      child: Column(
        children: [
          HomeAppBar(closeTop),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConditionalBuilder(
              condition: FastCubit.get(context).categoryModel!=null,
                fallback: (c)=>Center(child: CupertinoActivityIndicator(),),
                builder: (c)=> ConditionalBuilder(
                    condition: FastCubit.get(context).categoryModel!.body!.categories!.isNotEmpty,
                    fallback: (c)=>Center(child:Text(tr('no_category')),),
                    builder: (c)=> CategoryWidget()
                )
            ),
          ),
          Expanded(
              child: ListView.separated(
                itemBuilder: (c,i)=>ProductItem(),
                separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                itemCount: 5,
                controller: gridController,
                padding:const EdgeInsets.symmetric(horizontal: 20),
              )
          )
        ],
      ),
    );
  },
);
  }
}
