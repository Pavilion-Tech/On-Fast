import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_fast/shared/styles/colors.dart';

import '../../shared/images/images.dart';
import '../../widgets/item_shared/category_widget.dart';
import '../../widgets/item_shared/product_item.dart';
import '../../widgets/restaurant/app_bar.dart';
import '../../widgets/restaurant/info.dart';
import '../../widgets/restaurant/product.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

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
    return Scaffold(
      body: Column(
        children: [
          RestaurantAppBar(),
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
                  Column(
                    children: [
                      Padding(
                        padding:EdgeInsetsDirectional.only(top: 20,start: 20),
                        child: CategoryWidget(),
                      ),
                      Expanded(
                          child: ListView.separated(
                            itemBuilder: (c,i)=>Product(),
                            separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                            itemCount: 5,
                            padding: EdgeInsets.only(top: 20,right: 20,left: 20),
                          )
                      )
                    ],
                  ),
                  Info()
                ]
            ),
          )
        ],
      ),
    );
  }
}


