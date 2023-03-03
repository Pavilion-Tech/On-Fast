import 'package:flutter/material.dart';
import 'package:on_fast/modules/worng_screenss/wrong_screen.dart';
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
      ),
    );
  }
}
