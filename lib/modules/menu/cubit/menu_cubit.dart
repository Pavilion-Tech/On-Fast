import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_fast/modules/menu/cubit/menu_states.dart';
import '../../../models/settings_model.dart';
import '../../../shared/network/remote/dio.dart';
import '../../../shared/network/remote/end_point.dart';

class MenuCubit extends Cubit<MenuStates>{

  MenuCubit():super(MenuInitState());
  static MenuCubit get(context)=>BlocProvider.of(context);

  SettingsModel? settingsModel;

  void getSettings(){
    DioHelper.getData(
      url: settingsUrl,
    ).then((value) {
      if(value.data['body']!=null){
        settingsModel = SettingsModel.fromJson(value.data);
        emit(SettingsSuccessState());
      }else{
        emit(SettingsWrongState());
      }
    }).catchError((e){
      emit(SettingsErrorState());
    });
  }

}