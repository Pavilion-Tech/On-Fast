import 'package:flutter/material.dart';
import 'package:on_fast/modules/worng_screenss/wrong_screen.dart';
import 'package:on_fast/shared/images/images.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrongScreen(
        image: Images.update,
        title: 'update_title',
        desc: 'update_desc',
        textButton: 'update_now',
      ),
    );
  }
}
