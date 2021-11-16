import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/ui/pages/home_page.dart';
import 'package:world_builder/ui/pages/signup_page.dart';
import 'package:world_builder/ui/widgets/custom_button.dart';
import 'package:world_builder/ui/widgets/custom_text_field.dart';

import '../utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _data = {
    'email': '',
    'password': '',
  };

  void _onFieldChanged(String field, String value) => setState(() {
        _data[field] = value;
      });

  void _onLoginBtnClick() async {
    if (_formKey.currentState!.validate()) {
      Get.focusScope!.unfocus();
      final authOk = await Get.find<AuthController>().login(
        _data['email']!,
        _data['password']!,
      );
      if (authOk) {
        Get.off(() => const HomePage());
      } else {
        final status = _authController.currentStatus.value;
        if (status is AuthErrorStatus) {
          Get.snackbar('Error', status.errorMessage);
        }
      }
    }
  }

  void _onRegisterBtnClick() {
    Get.focusScope!.unfocus();
    Get.off(() => const SignupPage());
  }

  Widget _renderActionButtons() => Obx(() {
        if (_authController.currentStatus.value is AuthInProgressStatus) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                text: 'INICIANDO SESIÓN...',
                onClick: _onLoginBtnClick,
                solid: true,
                disabled: true,
              ),
              CustomButton(
                text: 'REGISTRARSE',
                onClick: _onRegisterBtnClick,
                disabled: true,
              ),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                text: 'INICIAR SESIÓN',
                onClick: _onLoginBtnClick,
                solid: true,
              ),
              CustomButton(
                text: 'REGISTRARSE',
                onClick: _onRegisterBtnClick,
              ),
            ],
          );
        }
      });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = Get.mediaQuery;
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
              stops: <double>[0, .23, .6],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 60),
                  SvgPicture.asset(
                    'assets/logo_login.svg',
                    semanticsLabel: 'World Builder Logo',
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    field: 'email',
                    label: 'Correo electrónico',
                    onChanged: _onFieldChanged,
                    type: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  const SizedBox(height: 25),
                  CustomTextField(
                    field: 'password',
                    label: 'Contraseña',
                    onChanged: _onFieldChanged,
                    type: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: passwordValidator,
                  ),
                  const SizedBox(height: 25),
                  _renderActionButtons(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
