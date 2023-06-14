import 'dart:convert';
import 'dart:developer';
import 'package:align_ai/widgets/components.dart';
import 'package:align_ai/widgets/cubit/states.dart';
import 'package:align_ai/widgets/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  LoginModel userModel;

  static ShopCubit get(context) => BlocProvider.of(context);


  void getUserData() {

    emit(ShopLoadingUserDataState());


    http
        .post(Uri.parse('https://powerhouse-zp6m.onrender.com/members/get/'),
         body: {
           "id": id.toString()
         })
        .then((response) {
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        userModel = LoginModel.fromJson(jsonData);
        log(userModel.userName);
        emit(ShopSuccessUserDataState(userModel));
      } else {
        emit(ShopErrorUserDataState());
        log('Request failed with status: ${response.statusCode}');
      }
    }).catchError((error, stackTrace) {
      emit(ShopErrorUserDataState());
      log(error.toString());
      log(stackTrace.toString());
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
        body: jsonEncode({
          'username': name,
          'email': email,
          'phone_number': phone,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        userModel = LoginModel.fromJson(data);
        print(userModel.userName);
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
