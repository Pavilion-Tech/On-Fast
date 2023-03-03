import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/widgets/home/app_bar.dart';

import '../../widgets/item_shared/category_widget.dart';
import '../../widgets/item_shared/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          HomeAppBar(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CategoryWidget(),
          ),
          Expanded(
              child: ListView.separated(
                itemBuilder: (c,i)=>ProductItem(),
                separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                itemCount: 5,
                padding:const EdgeInsets.symmetric(horizontal: 20),
              )
          )
        ],
      ),
    );
  }
}
