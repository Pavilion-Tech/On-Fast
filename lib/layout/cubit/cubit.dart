import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/layout/cubit/states.dart';
import '../../modules/cart/cart_screen.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/menu/menu_screen.dart';

class FastCubit extends Cubit<FastStates>{
  FastCubit(): super(FastInitState());
  static FastCubit get (context)=>BlocProvider.of(context);

  List<Widget> screens =
  [
    HomeScreen(),
    CartScreen(),
    MenuScreen(),
  ];
  int currentIndex = 0;

  void changeIndex(int index){
    currentIndex = index;
    emit(ChangeIndexState());
  }
}