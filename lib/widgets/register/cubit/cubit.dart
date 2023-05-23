import 'dart:developer';
import 'package:align_ai/widgets/login_model.dart';
import 'package:align_ai/widgets/network/end_point.dart';
import 'package:align_ai/widgets/network/remote/dio_helper.dart';
import 'package:align_ai/widgets/register/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

   LoginModel loginModel;

  void userRegister({
     String name,
     String email,
     String password,
     String phone,
  }) {
    log('enter loading register',name: 'loading register cubit');
    emit(ShopRegisterLoadingState());

    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {

      print(value.data); //must print not log

      loginModel = LoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error, stackTrace) {
      emit(ShopRegisterErrorState(error));
      print(error);
      print(stackTrace);
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
