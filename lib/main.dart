import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/shared/bloc_observer.dart';
import 'package:on_fast/shared/components/constant.dart';
import 'package:on_fast/shared/network/local/cache_helper.dart';
import 'package:on_fast/shared/network/remote/dio.dart';
import 'package:on_fast/splash_screen.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

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
    return MultiBlocProvider(
        providers:[
          BlocProvider(create:(context)=> FastCubit())
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

