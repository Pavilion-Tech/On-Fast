import 'dart:async';

import 'package:flutter/material.dart';
import 'package:on_fast/layout/layout_screen.dart';
import 'package:on_fast/modules/auth/login_screen.dart';
import 'package:on_fast/modules/worng_screenss/update_screen.dart';
import 'package:on_fast/shared/components/components.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/images/images.dart';
import 'package:video_player/video_player.dart';

import 'modules/intro/intro_screen.dart';
import 'modules/worng_screenss/maintenance_screen.dart';
import 'modules/worng_screenss/no_net_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(Images.splash)
      ..initialize().then((_) {
        setState(() {
          if (_controller.value.isInitialized) {
            _controller.play();
          }
        });
      });
    _controller.play();
    _controller.addListener(() {

      setState(() async {
        if (_controller.value.position >= _controller.value.duration){
        await  Future.delayed(Duration(seconds: 5));
          if(isIntro!=null){
            print("ramadan1");
            print(_controller.value.position);
            print(_controller.value.duration);
            navigateAndFinish(context, FastLayout());
          }else{
            navigateAndFinish(context, IntroScreen());
              }
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(() { });
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 300,
          width: 310,
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ),
      ),
    );
  }
}
