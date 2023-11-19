import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/cubit/states.dart';
import 'package:on_fast/modules/menu/cubit/menu_cubit.dart';
import 'package:on_fast/modules/menu/cubit/menu_states.dart';
import 'package:on_fast/modules/worng_screenss/maintenance_screen.dart';

import '../shared/components/components.dart';
import '../shared/components/constant.dart';
import '../shared/images/images.dart';
import '../shared/styles/colors.dart';
import 'nav_screen.dart';

class FastLayout extends StatefulWidget {
  const FastLayout({Key? key}) : super(key: key);

  @override
  State<FastLayout> createState() => _FastLayoutState();
}

class _FastLayoutState extends State<FastLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("beliedy");
  }
  @override
  Widget build(BuildContext context) {
    FastCubit.get(context).checkUpdate(context);
    return BlocConsumer<FastCubit, FastStates>(
      listener: (c, s) {
        if(isConnect!=null)checkNet(context);
      },
      builder: (context, state) {
        var cubit = FastCubit.get(context);
        return BlocConsumer<MenuCubit, MenuStates>(
          listener: (context, state) {
            if(isConnect!=null)checkNet(context);
            if(MenuCubit.get(context).settingsModel?.data?.isProjectInFactoryMode == 2){

              navigateAndFinish(context, MaintenanceScreen());
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: SafeArea(
                child: NavBar(
                  items: [
                    {
                      'icon':
                      Image.asset(Images.homeNo, width: 30, height: 30),
                      'activeIcon':
                      Image.asset(Images.homeYes, width: 30, height: 30,),
                    },
                    {
                      'icon':
                      Image.asset(Images.cartNo, width: 30, height: 30),
                      'activeIcon': Image.asset(
                        Images.cartYes, width: 30, height: 30,),
                    },
                    {
                      'icon':
                      Image.asset(Images.menu, width: 30, height: 30,),
                      'activeIcon':
                      Image.asset(Images.menu, width: 30,
                        height: 30,
                        color: defaultColor,),
                    },
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
