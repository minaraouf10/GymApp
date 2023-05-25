import 'dart:convert';
import 'dart:developer';
import 'package:align_ai/home_screen.dart';
import 'package:align_ai/widgets/components.dart';
import 'package:align_ai/widgets/login/cubit/states.dart';
import 'package:align_ai/widgets/login_model.dart';
import 'package:align_ai/widgets/network/end_point.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;




class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

   LoginModel loginModel;


//    void userLogin({
//      String email,
//      String password,
//   })async {
//     emit(ShopLoginLoadingState());
// try{
//     DioHelper.postData(url: LOGIN, data: {
//       'username_or_email': email,
//       'password': password,
//     }).then((value)  {
//       log(email,name: 'email dio');
//
//       print(value.data);
//        loginModel = LoginModel.fromJson(value.data);
//       print(loginModel.username);
//           print(loginModel.status);
//           print(loginModel.message);
//       log('login success',name: 'login');
//       emit(ShopLoginSuccessState(loginModel));
//     }).catchError((error,stackTrace) {
//
//       print(error);
//       print(stackTrace);
//       emit(ShopLoginErrorState(error.toString()));
//     });}
//     catch(e,s){
//   log(e.toString(),name: 'nana',stackTrace: s);
//     }
//   }


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
      print(loginModel.username);
      print(loginModel.status);
      print(loginModel.message);
      log('login success', name: 'login');
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
