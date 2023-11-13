import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/modules/auth/cubit/auth_cubit.dart';
import 'package:on_fast/modules/menu/cubit/menu_cubit.dart';
import 'package:on_fast/shared/bloc_observer.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/firebase_helper/firebase_options.dart';
import 'package:on_fast/shared/firebase_helper/notification_helper.dart';
import 'package:on_fast/shared/network/local/cache_helper.dart';
import 'package:on_fast/shared/network/remote/dio.dart';
import 'package:on_fast/splash_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'layout/cubit/cubit.dart';
import 'modules/chat/chat_cubit/chat_cubit.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  try{
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
    );
    NotificationHelper();
    fcmToken = await  FirebaseMessaging.instance.getToken();
  }catch(e){
    print(e.toString());
  }
  DioHelper.init1();
  await CacheHelper.init();
  lat = CacheHelper.getData(key: 'lat');
  lng = CacheHelper.getData(key: 'lng');
  id = CacheHelper.getData(key: 'id');
  token = CacheHelper.getData(key: 'token');
  isIntro = CacheHelper.getData(key: 'intro');
  String? loca = CacheHelper.getData(key: 'locale');
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  version = packageInfo.version;
  if(loca !=null){
    myLocale = loca;
  }else{
    Platform.localeName.contains('ar')
        ?myLocale = 'ar'
        :myLocale = 'en';
  }
  DioHelper.init1();
  BlocOverrides.runZoned(
        () {
      runApp(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          useOnlyLangCode: true,
          path: 'assets/langs',
          fallbackLocale: const Locale('en'),
          startLocale: Locale(myLocale),
          child: const MyApp(),
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color.fromRGBO(41, 167, 77, 50),
        //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.dark));
    return MultiBlocProvider(
        providers:[
          BlocProvider(create:(context)=> FastCubit()..checkInterNet()..init()),
          BlocProvider(create:(context)=> MenuCubit()..checkInterNet()..init()),
          BlocProvider(create:(context)=> AuthCubit()..checkInterNet()),
          BlocProvider(create:(context)=> ChatCubit() ),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            fontFamily: 'Cairo',
            appBarTheme: AppBarTheme(
                color: Colors.transparent,
                elevation: 0,iconTheme: IconThemeData(color: Colors.black)
            ),
            primarySwatch: Colors.blue,
          ),
          home:SplashScreen(),
        )
    );
  }
}

