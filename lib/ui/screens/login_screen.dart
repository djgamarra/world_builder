import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/ui/screens/homepage.dart';
import 'package:world_builder/ui/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _data = {
    'email': '',
    'password': '',
  };

  String? _emailValidator(String? email) {
    if (email == null) {
      return 'Escriba su correo';
    }
    final hasMatch = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
    if (!hasMatch) {
      return 'Correo electrónico inválido';
    }
    return null;
  }

  String? _passwordValidator(String? password) {
    if (password == null) {
      return 'Escriba su contraseña';
    }
    if (password.length < 6) {
      return 'Contraseña demasiado corta';
    }
    return null;
  }

  _onFieldChanged(String key) => (text) => setState(() {
        _data[key] = text ?? '';
      });

  void _onLoginBtnClick() {
    if (_formKey.currentState!.validate()) {
      Get.find<AuthController>().login(
        _data['email']!,
        _data['password']!,
      );
    }
  }

  void _onRegisterBtnClick() {
    Get.off(const RegisterScreen());
  }

  @override
  Widget build(BuildContext context) {
    const String logoUrl = 'assets/logo_login.svg';
    final mediaQuery = MediaQuery.of(context);
    final authController = Get.find<AuthController>();
    authController.errorMessage.listen((errorMessage) {
      if (errorMessage != null) {
        Get.snackbar('Error', errorMessage);
      }
    });
    authController.currentStatus.listen((authStatus) {
      if (authStatus == AuthStatus.loggedIn) {
        Get.off(const HomePage());
      }
    });
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
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
            height: mediaQuery.size.height * .7,
            width: mediaQuery.size.width,
            decoration: const BoxDecoration(
              color: Color(0xAACCDDE7),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
            ),
            // ignore: sized_box_for_whitespace
            child: Container(
              width: mediaQuery.size.width * .85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SvgPicture.asset(
                    logoUrl,
                    semanticsLabel: 'World Builder Logo',
                    fit: BoxFit.scaleDown,
                  ),
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: mediaQuery.size.width * .85,
                    height: mediaQuery.size.height * .5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Correo electrónico',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: _onFieldChanged('email'),
                              validator: _emailValidator,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Contraseña',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              onChanged: _onFieldChanged('password'),
                              validator: _passwordValidator,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: _onLoginBtnClick,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: const Color(0xFF92D8FF),
                            fixedSize: Size(mediaQuery.size.width * 0.4, 50),
                          ),
                          child: Text(
                            "LOGIN",
                            style: GoogleFonts.play(fontSize: 18),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _onRegisterBtnClick,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.white,
                            fixedSize: Size(mediaQuery.size.width * 0.4, 50),
                          ),
                          child: Text(
                            "REGISTRO",
                            style: GoogleFonts.play(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
