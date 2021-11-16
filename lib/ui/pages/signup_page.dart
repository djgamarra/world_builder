import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/controllers/regions_controller.dart';
import 'package:world_builder/models/region.dart';
import 'package:world_builder/ui/constants.dart';
import 'package:world_builder/ui/pages/login_page.dart';
import 'package:world_builder/ui/utils.dart';
import 'package:world_builder/ui/widgets/custom_button.dart';
import 'package:world_builder/ui/widgets/custom_text_field.dart';

import 'home_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _authController = Get.find<AuthController>();
  final _regionsController = Get.find<RegionsController>();

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _data = {
    'username': '',
    'fullName': '',
    'email': '',
    'password': '',
    'region': '',
  };

  void _onFieldChanged(String field, String value) => setState(() {
        _data[field] = value;
      });

  void _onRegionChanged(String? value) => setState(() {
        _data['region'] = value ?? '';
      });

  void _onSignupBtnClick() async {
    if (_formKey.currentState!.validate()) {
      Get.focusScope!.unfocus();
      final authOk = await _authController.register(
        _data['email']!,
        _data['password']!,
        _data['username']!,
        _data['fullName']!,
        _data['region']!,
      );
      if (authOk) {
        Get.snackbar('Correcto', 'Usuario creado exitosamente');
        Get.off(() => const HomePage());
      } else {
        final status = _authController.currentStatus.value;
        if (status is AuthErrorStatus) {
          Get.snackbar('Error', status.errorMessage);
        }
      }
    }
  }

  void _onLoginBtnClick() {
    Get.focusScope!.unfocus();
    Get.off(() => const LoginPage());
  }

  Widget _renderRegionsDropdown() => Obx(() {
        switch (_regionsController.loadStatus.value) {
          case DataLoadStatus.loaded:
            if ((_data['region'] ?? '') == '') {
              _data['region'] = _regionsController.data.value[0].code;
            }
            return DropdownButton(
              borderRadius: BorderRadius.circular(10),
              autofocus: true,
              elevation: 0,
              icon: const Icon(Icons.keyboard_arrow_down),
              value: _data['region'],
              items: _regionsController.data.value.map((Region region) {
                return DropdownMenuItem(
                  value: region.code,
                  child: Text(
                    region.name,
                    style: primaryFont.copyWith(
                      fontSize: 17,
                    ),
                  ),
                );
              }).toList(),
              onChanged: _onRegionChanged,
            );
          default:
            return DropdownButton(
              borderRadius: BorderRadius.circular(10),
              autofocus: true,
              elevation: 0,
              icon: const Icon(Icons.keyboard_arrow_down),
              value: 'loading',
              items: [
                DropdownMenuItem(
                  value: 'loading',
                  child: Text(
                    'Cargando...',
                    style: primaryFont.copyWith(
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            );
        }
      });

  Widget _renderActionButtons() => Obx(() {
        if (_authController.currentStatus.value is AuthInProgressStatus) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                text: 'INICIAR SESIÓN',
                onClick: _onLoginBtnClick,
                disabled: true,
              ),
              CustomButton(
                text: 'CREANDO USUARIO...',
                onClick: _onSignupBtnClick,
                solid: true,
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
              ),
              CustomButton(
                text: 'REGISTRARSE',
                onClick: _onSignupBtnClick,
                solid: true,
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
        child: SingleChildScrollView(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Región:  ',
                          style: primaryFont.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _renderRegionsDropdown(),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      field: 'username',
                      label: 'Nombre de usuario',
                      onChanged: _onFieldChanged,
                      type: TextInputType.name,
                      validator: usernameValidator,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      field: 'fullName',
                      label: 'Nombre completo',
                      onChanged: _onFieldChanged,
                      type: TextInputType.name,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      field: 'email',
                      label: 'Correo electrónico',
                      onChanged: _onFieldChanged,
                      type: TextInputType.emailAddress,
                      validator: emailValidator,
                    ),
                    const SizedBox(height: 10),
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
      ),
    );
  }
}
