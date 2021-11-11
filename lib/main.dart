import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:world_builder/services/blocs/auth/auth_bloc.dart';
import 'package:world_builder/ui/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    Get.put<AuthBloc>(AuthBloc());
    return GetMaterialApp(
      title: 'World Builder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFFCCDDE7, <int, Color>{
          50: Color(0xFFF9FBFC),
          100: Color(0xFFF0F5F8),
          200: Color(0xFFE6EEF3),
          300: Color(0xFFDBE7EE),
          400: Color(0xFFD4E2EB),
          500: Color(0xFFCCDDE7),
          600: Color(0xFFC7D9E4),
          700: Color(0xFFC0D4E0),
          800: Color(0xFFB9CFDD),
          900: Color(0xFFADC7D7),
        }),
        fontFamily: "Roboto",
      ),
      home: const SplashScreen(),
    );
  }
}
