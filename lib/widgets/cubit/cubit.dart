import 'dart:convert';
import 'dart:developer';
import 'package:align_ai/widgets/constants.dart';
import 'package:align_ai/widgets/cubit/states.dart';
import 'package:align_ai/widgets/login_model.dart';
import 'package:align_ai/widgets/network/end_point.dart';
import 'package:align_ai/widgets/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;



class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  LoginModel userModel;

  static ShopCubit get(context) => BlocProvider.of(context);

  Map<int, bool> favorite = {};

  // void getUserData() {
  //
  //   emit(ShopLoadingUserDataState());
  //
  //   DioHelper.getData(
  //       url: PROFILE,
  //       token: token
  //   ).then((value) {
  //     userModel = LoginModel.fromJson(value.data);
  //     log(userModel.username);
  //     // printFullText(homeModel?.data.banners[0].image.toString());
  //
  //     emit(ShopSuccessUserDataState(userModel));
  //   }).catchError((error, stackTrace) {
  //     emit(ShopErrorUserDataState());
  //     log(error);
  //     log(stackTrace);
  //   });
  // }

//   void updateUserData({
//      String name,
//      String email,
//      String phone,
// }) {
//
//     emit(ShopLoadingUpdateUserState());
//
//     DioHelper.putData(
//         url: UPDATE_PROFILE,
//         token: token,
//       data: {
//           'name':name,
//           'email':email,
//           'phone':phone,
//       }
//     ).then((value) {
//       userModel = LoginModel.fromJson(value.data);
//       print(userModel.username);
//       // printFullText(homeModel?.data.banners[0].image.toString());
//
//       emit(ShopSuccessUpdateUserState(userModel));
//     }).catchError((error, stackTrace) {
//       emit(ShopErrorUpdateUserState());
//       print(error.toString());
//       print(stackTrace.toString());
//     });
//   }



  void getUserData() {
    emit(ShopLoadingUserDataState());

    http.get(Uri.parse('https://powerhouse-zp6m.onrender.com/members/get/24/'), headers: {
      // 'Authorization': token,
    }).then((response) {
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        userModel = LoginModel.fromJson(jsonData);
        log(userModel.username);
        emit(ShopSuccessUserDataState(userModel));
      } else {
        emit(ShopErrorUserDataState());
        log('Request failed with status: ${response.statusCode}');
      }
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
  }) async {
    emit(ShopLoadingUpdateUserState());

    try {
      final response = await http.put(
        Uri.parse('https://powerhouse-zp6m.onrender.com/members/update/'),
        // headers: {
        //   'Content-Type': 'application/json',
        //   'Authorization': token,
        // },
        body: jsonEncode({
          'username': name,
          'email': email,
          'phone_number': phone,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        userModel = LoginModel.fromJson(data);
        print(userModel.username);
        emit(ShopSuccessUpdateUserState(userModel));
      } else {
        emit(ShopErrorUpdateUserState());
        print('Update user data failed with status code: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      emit(ShopErrorUpdateUserState());
      print(error.toString());
      print(stackTrace.toString());
    }
  }

}
