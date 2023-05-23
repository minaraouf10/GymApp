/*
* base url: https://newsapi.org/
* method (url):v2/top-headlines?
* queries : country=eg&category=business&apiKey=278c9e315eb04c99bd1ba401b8d25cef
* */

import 'package:align_ai/widgets/components.dart';
import 'package:align_ai/widgets/login/login_screen.dart';
import 'package:align_ai/widgets/network/local/cache_helper.dart';


void signOUT (context){
  CacheHelper.sharedPreferences.remove('token').then((value)  {
    if(value){
      navigateAndFinish(context,ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';