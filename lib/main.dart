import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/controllers/core_data_controller.dart';
import 'package:world_builder/services/authentication_service.dart';
import 'package:world_builder/services/firestore_service.dart';
import 'package:world_builder/ui/screens/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authService = Get.put(AuthenticationService());
  final firestoreService = Get.put(FirestoreService());
  final authController = Get.put(AuthController(
    authenticationService: authService,
    firestoreService: firestoreService,
  ));
  final coreDataController = Get.put(CoreDataController(
    firestoreService: firestoreService,
  ));
  await authController.init();
  await coreDataController.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      home: const SplashPage(),
    );
  }
}
