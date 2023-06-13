import 'dart:convert';
import 'dart:developer';
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

  await  http.post(Uri.parse('https://powerhouse-zp6m.onrender.com/members/create/'),
      body: {
      'first_name': firstName,
      'last_name': lastName,
      'username': userName,
      'height': height,
      'weight': weight,
      'gender': gender,
      'address': address,
      'gym_name': gym,
      'email': email,
      'password': password,
      'phone_number': phone,
    }).then((response) {
      log(response.body,name: 'body'); // Print the response body

        registerModel = RegisterModel.fromJson(json.decode(response.body));
        log(registerModel.data.email.toString(),name: 'email register');
        log(registerModel.status.toString());
        emit(ShopRegisterSuccessState(registerModel));

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
