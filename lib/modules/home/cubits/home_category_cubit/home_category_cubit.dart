import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:on_fast/models/ads_model.dart';
import 'package:on_fast/shared/network/remote/end_point.dart';
import '../../../../models/category_model.dart';
import '../../../../models/provider_category_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constant.dart';
import '../../../../shared/network/remote/dio.dart';
import 'home_category_states.dart';

class HomeCategoryCubit extends Cubit<HomeCategoryStates>{
  HomeCategoryCubit(): super(HomeCategoryInitState());
  static HomeCategoryCubit get (context)=>BlocProvider.of(context);


  LatLng? position;
  CategoriesModel? categoriesModel;
  String categoryId = '';
  TextEditingController locationController = TextEditingController();

  void init()async{
    if(lat!=null){
      position = LatLng(lat!, lng!);
      getAddress(position!);
    }else{
      getCurrentLocation();
    }


  }

  Future<void> getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    await checkPermissions();
    await Geolocator.getLastKnownPosition().then((value) {
      if (value != null) {
        position = LatLng(value.latitude, value.longitude);
        getAddress(position!);
         getProviderCategory();
        emit(GetCurrentLocationState());
      }
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
      //await Geolocator.openLocationSettings();
      emit(GetCurrentLocationState());
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }



  Future<void> getAddress(LatLng latLng) async {
    List<Placemark> place = await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude,
        localeIdentifier: myLocale);
    Placemark placeMark = place[0];
    locationController.text = placeMark.street!;
    locationController.text += ', ${placeMark.country!}';
    emit(GetCurrentLocationState());
  }
  void getCategory(){
    emit(HomeCategoryLoadingState());
    DioHelper.getData(
      url: categoryUrl,
    ).then((value) {
      if(value.data['data']!=null){
        categoriesModel = CategoriesModel.fromJson(value.data);
        categoryId = categoriesModel!.data![0].id??'';

        emit(HomeCategorySuccessState());
        getProviderCategory();
      }else{
        emit(HomeCategoryWrongState());
      }
    }).catchError((e){
      emit(HomeCategoryErrorState());
    });
  }


  String categorySearchId = '';



  ProviderCategoryModel? providerCategoryModel;
  void getProviderCategory({int page = 1}){
    String url;
    if(position!=null){
      url = '$providerCategoryUrl$categoryId?user_latitude=${position!.latitude}&user_logitude=${position!.longitude}&page=$page';
    }else{
      url = '$providerCategoryUrl$categoryId?page=$page';
    }
    emit(ProviderCategoryLoadingState());
    DioHelper.getData(
        url: url,
        token: 'Bearer $token'
    ).then((value) {
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          providerCategoryModel = ProviderCategoryModel.fromJson(value.data);
          print("providerCategoryModelproviderCategoryModel");
          print(providerCategoryModel?.data?.data?.length);
        }
        else{
          providerCategoryModel!.data!.currentPage = value.data['data']['currentPage'];
          providerCategoryModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            providerCategoryModel!.data!.data!.add(ProviderData.fromJson(e));
          });
        }
        emit(ProviderCategorySuccessState());


      }else if(value.data['status']==false&&value.data['data']!=null){
        showToast(msg: tr('wrong'));
        emit(ProviderCategoryWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      emit(ProviderCategoryErrorState());
    });
  }

  void paginationProviderCategory(ScrollController controller){
    controller.addListener(() {
      if (controller.offset == controller.position.maxScrollExtent){
        if (providerCategoryModel!.data!.currentPage != providerCategoryModel!.data!.pages) {
          if(state is! ProviderCategoryLoadingState){
            int currentPage = providerCategoryModel!.data!.currentPage! +1;
            getProviderCategory(page: currentPage);
          }
        }
      }
    });
  }


  ProviderCategoryModel? providerCategorySearchModel;
  void getProviderCategorySearch({int page = 1,required String search}){
    String url;
    if(position!=null){
      url = '$providerCategoryUrl$categorySearchId?user_latitude=${position!.latitude}&user_logitude=${position!.longitude}&page=$page&name=$search';
    }else{
      url = '$providerCategoryUrl$categorySearchId?page=$page&name=$search';
    }
    print(url);
    emit(ProviderCategorySearchLoadingState());
    DioHelper.getData(
        url: url,
        token: 'Bearer $token'
    ).then((value) {
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          providerCategorySearchModel = ProviderCategoryModel.fromJson(value.data);
        }
        else{
          providerCategorySearchModel!.data!.currentPage = value.data['data']['currentPage'];
          providerCategorySearchModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            providerCategorySearchModel!.data!.data!.add(ProviderData.fromJson(e));
          });
        }
        emit(ProviderCategorySearchSuccessState());
      }else if(value.data['status']==false&&value.data['data']!=null){
        showToast(msg: tr('wrong'));
        emit(ProviderCategorySearchWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      emit(ProviderCategorySearchErrorState());
    });
  }

  ScrollController providerSearchScrollController = ScrollController();
  void paginationProviderCategorySearch(String search){
    providerSearchScrollController.addListener(() {
      if (providerSearchScrollController.offset == providerSearchScrollController.position.maxScrollExtent){
        if (providerCategorySearchModel!.data!.currentPage != providerCategorySearchModel!.data!.pages) {
          if(state is! ProviderCategorySearchLoadingState){
            int currentPage = providerCategorySearchModel!.data!.currentPage! +1;
            getProviderCategorySearch(page: currentPage,search: search);
          }
        }
      }
    });
  }

  void emitState()=>emit(EmitState());
}