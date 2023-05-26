import 'package:align_ai/widgets/login/login_screen.dart';
import 'package:align_ai/widgets/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'main_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: ShopLoginScreen(),
      routes: {
        MainScreen.id: (context) => MainScreen(cameras),
        //DemoScreen.id: (context) => DemoScreen(),
      },
    );
  }
}
