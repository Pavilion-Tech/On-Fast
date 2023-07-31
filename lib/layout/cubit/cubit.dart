import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:on_fast/layout/cubit/states.dart';
import 'package:on_fast/shared/network/remote/end_point.dart';
import '../../models/category_model.dart';
import '../../models/home_model.dart';
import '../../modules/cart/cart_screen.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/menu/menu_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/network/remote/dio.dart';

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

  Position? position;

  CategoryModel? categoryModel;

  HomeModel? homeModel;

  void changeIndex(int index){
    currentIndex = index;
    emit(ChangeIndexState());
  }

  void emitState()=>emit(EmitState());

  void init()async{
    await getCurrentLocation();
    getCategory();
    getHome();
  }

  void getHome(){
    DioHelper.getData(
      url: homeUrl,
      query: {
        'lat':position?.latitude,
        'lng':position?.longitude,
      }
    ).then((value) {
      print(value.data);
      if(value.data['body']!=null){
        homeModel = HomeModel.fromJson(value.data);
        emit(HomeSuccessState());
      }else{
        emit(HomeWrongState());
      }
    }).catchError((e){
      emit(HomeErrorState());
    });
  }

  void getCategory(){
    DioHelper.getData(
      url: categoryUrl,
    ).then((value) {
      if(value.data['body']!=null){
        categoryModel = CategoryModel.fromJson(value.data);
        emit(HomeSuccessState());
      }else{
        emit(HomeWrongState());
      }
    }).catchError((e){
      emit(HomeErrorState());
    });
  }

  Future<Position> checkPermissions() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!isServiceEnabled) {}
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast(msg: 'Location permissions are denied', toastState: false);
        emit(GetCurrentLocationState());
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showToast(msg: 'Location permissions are permanently denied, we cannot request permissions.', toastState: false);
      await Geolocator.openLocationSettings();
      emit(GetCurrentLocationState());
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    await checkPermissions();
    await Geolocator.getLastKnownPosition().then((value) {
      if (value != null) {
        position = value;
        emit(GetCurrentLocationState());
      }
    });
  }
}