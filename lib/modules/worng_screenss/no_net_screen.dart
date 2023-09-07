import 'package:flutter/material.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/layout/layout_screen.dart';
import 'package:on_fast/modules/menu/cubit/menu_cubit.dart';
import 'package:on_fast/modules/worng_screenss/wrong_screen.dart';
import 'package:on_fast/shared/components/components.dart';
import 'package:on_fast/shared/images/images.dart';

class NoNetScreen extends StatelessWidget {
  const NoNetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrongScreen(
        image: Images.noNet,
        title: 'no_net_title',
        desc: 'no_net_desc',
        textButton: 'reload',
        onTap: (){
          FastCubit.get(context).init();
          MenuCubit.get(context).init();
          navigateAndFinish(context, FastLayout());
        },
      ),
    );
  }
}
