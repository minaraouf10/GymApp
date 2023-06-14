import 'package:align_ai/widgets/cubit/cubit.dart';
import 'package:align_ai/widgets/cubit/states.dart';
import 'package:align_ai/widgets/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: MaterialColor(0xFFFE7C7C, <int, Color>{
                50: Color(0xFFFFF0F0),
                100: Color(0xFFFFD2D2),
                200: Color(0xFFFFA4A4),
                300: Color(0xFFFF7676),
                400: Color(0xFFFF4848),
                500: Color(0xFFFE7C7C),
                600: Color(0xFFFE4E4E),
                700: Color(0xFFFE2020),
                800: Color(0xFFFE0C0C),
                900: Color(0xFFFE0606),
              }),
            ),
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            home: ShopLoginScreen(),
            routes: {
              MainScreen.id: (context) => MainScreen(cameras),
              //DemoScreen.id: (context) => DemoScreen(),
            },
          );
        },
      ),
    );
  }
}

