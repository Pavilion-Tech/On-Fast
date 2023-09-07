import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:on_fast/layout/cubit/cubit.dart';
import 'package:on_fast/modules/auth/cubit/auth_states.dart';
import 'package:on_fast/modules/menu/cubit/menu_cubit.dart';
import 'package:on_fast/shared/components/components.dart';
import 'package:on_fast/shared/network/local/cache_helper.dart';
import 'package:on_fast/shared/network/remote/dio.dart';

import '../../../shared/components/constant.dart';
import '../../../shared/network/remote/end_point.dart';
import '../verification.dart';

class AuthCubit extends Cubit<AuthStates>{

  AuthCubit():super(AuthInitState());

  static AuthCubit get(context)=>BlocProvider.of(context);

  TextEditingController phoneController = TextEditingController();

  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(EmitState());
    });
  }


  void login({BuildContext? context}){
    emit(LoginLoadingState());
    DioHelper.postData(
      url: loginUrl,
      data: {
          'phone_number':phoneController.text,
          'firebase_token':fcmToken,
          'current_language':myLocale,
      }
    ).then((value) {
      print(value.data);
      if(value.data['data']!=null){
        id = value.data['data']['user_id'];
        CacheHelper.saveData(key: 'id', value: id);
        code =  value.data['data']['code'];
        showToast(msg:'${tr('code_is')} $code',gravity: ToastGravity.CENTER);
        if(context!=null)
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(50),
                  topStart: Radius.circular(50),
                )
            ),
            builder: (context) => Verification()
        );
        emit(LoginSuccessState());
      }else{
        showToast(msg: tr('wrong'));
        emit(LoginWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'),toastState: false);
      emit(LoginErrorState());
    });
  }

  void verificationCode(BuildContext context){
    emit(VerificationCodeLoadingState());
    DioHelper.postData(
        url: verificationCodeUrl,
        data: {
          'user_id':id,
          'code':code,
        }
    ).then((value) {
      if(value.data['data']!=null){
        token = value.data['data']['token'];
        CacheHelper.saveData(key: 'token', value: token);
        if(FastCubit.get(context).adsModel!=null){
          MenuCubit.get(context).init();
          FastCubit.get(context).init();
        }
        phoneController.text = '';
        emit(VerificationCodeSuccessState());
      }else{
        emit(VerificationCodeWrongState());
      }
    }).catchError((e){
      emit(VerificationCodeErrorState());
    });
  }
}