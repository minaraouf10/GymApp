import 'dart:convert';
import 'dart:developer';
import 'package:align_ai/widgets/login_model.dart';
import 'package:align_ai/widgets/network/end_point.dart';
import 'package:align_ai/widgets/network/remote/dio_helper.dart';
import 'package:align_ai/widgets/register/cubit/states.dart';
import 'package:align_ai/widgets/register_model.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  RegisterModel registerModel;

  // void userRegister({
  //    String name,
  //    String email,
  //    String password,
  //    String phone,
  // }) {
  //   log('enter loading register',name: 'loading register cubit');
  //   emit(ShopRegisterLoadingState());
  //
  //   DioHelper.postData(url: REGISTER, data: {
  //     'name': name,
  //     'email': email,
  //     'password': password,
  //     'phone': phone,
  //   }).then((value) {
  //
  //     print(value.data); //must print not log
  //
  //     loginModel = LoginModel.fromJson(value.data);
  //     emit(ShopRegisterSuccessState(loginModel));
  //   }).catchError((error, stackTrace) {
  //     emit(ShopRegisterErrorState(error));
  //     print(error);
  //     print(stackTrace);
  //   });
  // }

  void userRegister({
    String firstName,
    String lastName,
    String userName,
    String height,
    String weight,
    String gender,
    String address,
    String gym,
    String email,
    String password,
    String phone,
  }) async{
    log('enter loading register', name: 'loading register cubit');
    emit(ShopRegisterLoadingState());

  await  http.post(Uri.parse('https://powerhousegym-8n6h.onrender.com/members/create/'),
      body: {
      'first_name': firstName,
      'last_name': lastName,
      'username': userName,
      'height': height,
      'weight': weight,
      'gender': gender,
      'address': address,
      'gym': gym,
      'email': email,
      'password': password,
      'phone_number': phone,
    }).then((response) {
      print(response.body); // Print the response body

      if (response.statusCode == 200) {
        registerModel = RegisterModel.fromJson(json.decode(response.body));
        log(registerModel.data.email.toString());
        log(registerModel.status.toString());
        emit(ShopRegisterSuccessState(registerModel));
      } else {
        emit(ShopRegisterErrorState('Error: ${response.statusCode}'));
      }
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
      print(error);
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
