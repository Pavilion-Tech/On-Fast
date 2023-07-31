import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/modules/auth/cubit/auth_cubit.dart';
import 'package:on_fast/shared/bloc_observer.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/network/local/cache_helper.dart';
import 'package:on_fast/shared/network/remote/dio.dart';
import 'package:on_fast/splash_screen.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init1();
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token');
  isIntro = CacheHelper.getData(key: 'intro');
  String? loca = CacheHelper.getData(key: 'locale');
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
          BlocProvider(create:(context)=> FastCubit()..init()),
          BlocProvider(create:(context)=> AuthCubit()),
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

