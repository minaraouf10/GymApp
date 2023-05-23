import 'dart:convert';
import 'dart:developer';
import 'package:align_ai/widgets/constants.dart';
import 'package:align_ai/widgets/cubit/states.dart';
import 'package:align_ai/widgets/login_model.dart';
import 'package:align_ai/widgets/network/end_point.dart';
import 'package:align_ai/widgets/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  LoginModel userModel;

  static ShopCubit get(context) => BlocProvider.of(context);





  Map<int, bool> favorite = {};








  void getUserData() {

    emit(ShopLoadingUserDataState());

    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      log(userModel.username);
      // printFullText(homeModel?.data.banners[0].image.toString());

      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error, stackTrace) {
      emit(ShopErrorUserDataState());
      log(error);
      log(stackTrace);
    });
  }

  void updateUserData({
     String name,
     String email,
     String phone,
}) {

    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
      data: {
          'name':name,
          'email':email,
          'phone':phone,
      }
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel.username);
      // printFullText(homeModel?.data.banners[0].image.toString());

      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error, stackTrace) {
      emit(ShopErrorUpdateUserState());
      print(error.toString());
      print(stackTrace.toString());
    });
  }
}
