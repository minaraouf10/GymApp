import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../components.dart';
import '../../login_model.dart';
import 'states.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

   LoginModel loginModel;

 Future<void> userLogin({
    String email,
    String password,
  }) async {
    emit(ShopLoginLoadingState());

    final response = await http.post(Uri.parse('https://powerhouse-zp6m.onrender.com/login/'),
        body: {
          'username_or_email': email,
          'password': password,
        });

    if (response.statusCode == 200) {
      log(email, name: 'email dio');
      print(response.body);
      loginModel = LoginModel.fromJson(json.decode(response.body));
      print(loginModel.status);
      print(loginModel.message);
      print(loginModel.id);
      id = loginModel.id;
      log('login success', name: 'login');
      log(id.toString() , name: 'id');
      emit(ShopLoginSuccessState(loginModel));
    } else {
      print('Error: ${response.statusCode}');
      emit(ShopLoginErrorState('Error: ${response.statusCode}'));
    }
  }



  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}
