import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/ui/screens/login_screen.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authController = Get.find<AuthController>();

  void _onLoginBtnClick() {
    if (_authController.currentStatus.value == AuthStatus.loggedIn) {
      Get.off(() => const HomePage());
    } else {
      Get.off(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          // alignment: Alignment.bottomCenter,
          width: mediaQuery.size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0x00CCDDE7),
                Color(0x88CCDDE7),
                Color(0xAACCDDE7),
              ],
              stops: <double>[0, .3, .6],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 40),
              Image.asset(
                "assets/logo_multi.png",
                width: mediaQuery.size.width * .6,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Text(
                  "Lee, crea y comparte historias, ¿qué estás esperando para unirte a nuestra comunidad?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 51),
                    primary: Colors.white,
                    elevation: 0,
                  ),
                  onPressed: _onLoginBtnClick,
                  child: Text(
                    "INGRESAR",
                    style: GoogleFonts.play(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }
}
