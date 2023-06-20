import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../components.dart';
import '../login_model.dart';
import 'states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  LoginModel userModel;

  static ShopCubit get(context) => BlocProvider.of(context);

  void getUserData() {
    emit(ShopLoadingUserDataState());

    http.post(Uri.parse('https://powerhouse-zp6m.onrender.com/members/get/'),
        body: {"id": id.toString()}).then((response) {
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
    String userName,
    String email,
    String phone,
    String firstName,
    String lastName,
    String height,
    String weight,
    String address,
    String gender,
    String gymName,
  }) async {
    emit(ShopLoadingUpdateUserState());

    try {
      final response = await http.put(
        Uri.parse('https://powerhouse-zp6m.onrender.com/members/update/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id':id.toString(),
          'username': userName,
          'email': email,
          'phone_number': phone,
          'first_name': firstName,
          'last_name': lastName,
          'gym_name': gymName,
          'gender': gender,
          'address': address,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        userModel = LoginModel.fromJson(data);
        log(userModel.userName.toString(),name: 'user name update');
        emit(ShopSuccessUpdateUserState(userModel));
      } else {
        emit(ShopErrorUpdateUserState());
        print(
            'Update user data failed with status code: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace.toString());
      emit(ShopErrorUpdateUserState());

    }
  }
}
