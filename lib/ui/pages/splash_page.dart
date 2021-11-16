import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/ui/constants.dart';
import 'package:world_builder/ui/pages/login_page.dart';
import 'package:world_builder/ui/widgets/custom_button.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _authController = Get.find<AuthController>();

  void _onLoginBtnClick() async {
    final authOk = await _authController.reLogin();
    if (authOk) {
      Get.off(() => const HomePage());
    } else {
      Get.off(() => const LoginPage());
    }
  }

  Widget _renderActionButton() => Obx(() {
        if (_authController.currentStatus.value is AuthInProgressStatus) {
          return CustomButton(
            text: 'INGRESANDO...',
            fullWidth: true,
            onClick: _onLoginBtnClick,
            fontSize: 16,
            borderWidth: 1.5,
            disabled: true,
          );
        } else {
          return CustomButton(
            text: 'INGRESAR',
            fullWidth: true,
            onClick: _onLoginBtnClick,
            fontSize: 16,
            borderWidth: 1.5,
          );
        }
      });

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
                  style: primaryFont.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: _renderActionButton(),
              ),
              const SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }
}
