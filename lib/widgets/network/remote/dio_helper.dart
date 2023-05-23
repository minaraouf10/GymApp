import 'dart:developer';

import 'package:dio/dio.dart';

class DioHelper {
  static  Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://powerhousegym-8n6h.onrender.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
     String url,
     Map<String, dynamic> query,
    String lang = 'en',
    String token
  }) async {
    // dio.options.headers ={
    //   // 'Content-Type':'application/json',
    //   // 'lang':lang,
    //   // 'Authorization':token ?? ''
    // };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response>postData({
     String url,
     Map<String, dynamic> data,
    Map<String, dynamic> query,
    String lang = 'en',
    String token
}) async{
    // dio.options.headers ={
    //   // 'lang':lang,
    //   // 'Authorization':token
    // };
    return await dio.post(
      url,
      queryParameters: query,
      data:data
    );
  }

  // static Future<Response>postData({
  //
  //   Map<String, dynamic>? query,
  //   String lang = 'en',
  //   String? token
  // }) async{
  //   dio.options.headers ={
  //     'lang':lang,
  //     'Authorization':token
  //   };
  //   return await dio.post(
  //       url,
  //       queryParameters: query,
  //       data:data
  //   );
  // }

  static Future<Response>putData({
     String url,
    Map<String, dynamic> data,
    Map<String, dynamic> query,
    String lang = 'en',
    String token
  }) async{
    // dio.options.headers ={
    //   // 'lang':lang,
    //   // 'Authorization':token
    // };
    return await dio.put(
        url,
        queryParameters: query,
        data:data
    );
  }
}
