import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/cubit/states.dart';

import '../shared/images/images.dart';
import '../shared/styles/colors.dart';
import 'nav_screen.dart';

class FastLayout extends StatelessWidget {
  const FastLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit,FastStates>(
      listener: (c,s){},
      builder: (context,state){
        var cubit = FastCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: SafeArea(
            child: NavBar(
              items: [
                {
                  'icon':
                  Image.asset(Images.homeNo,width: 30,height: 30),
                  'activeIcon':
                  Image.asset(Images.homeYes,width: 30,height: 30,),
                },
                {
                  'icon':
                  Image.asset(Images.cartNo,width: 30,height: 30),
                  'activeIcon':Image.asset(Images.cartYes,width: 30,height: 30,),
                },
                {
                  'icon':
                  Image.asset(Images.menu,width: 30,height: 30,),
                  'activeIcon':
                  Image.asset(Images.menu,width: 30,height: 30,color: defaultColor,),
                },
              ],
            ),
          ),
        );
    },
    );
  }
}
