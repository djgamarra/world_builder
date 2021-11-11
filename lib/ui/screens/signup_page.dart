import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/controllers/core_data_controller.dart';
import 'package:world_builder/models/region.dart';
import 'package:world_builder/ui/screens/login_page.dart';
import 'package:world_builder/ui/utils.dart';

import 'homepage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _authController = Get.find<AuthController>();
  final _coreDataController = Get.find<CoreDataController>();

  List<Region> _regions = [];
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _data = {
    'username': '',
    'fullName': '',
    'email': '',
    'password': '',
    'region': '',
  };

  _SignupPageState() {
    _regions = _coreDataController.regions.value;
    _data['region'] = _regions[0].code;
    _coreDataController.regions.listen((regions) {
      setState(() {
        _regions = regions;
        _data['region'] = _regions[0].code;
      });
    });
    _authController.errorMessage.listen((errorMessage) {
      if (errorMessage != null) {
        Get.snackbar('Error', errorMessage);
      }
    });
    _authController.currentStatus.listen((authStatus) {
      if (authStatus == AuthStatus.loggedIn) {
        Get.snackbar('Correcto', 'Usuario creado exitosamente');
        Get.off(() => const HomePage());
      }
    });
  }

  _onFieldChanged(String key) => (text) => setState(() {
        _data[key] = text ?? '';
      });

  void _onSignupBtnClick() {
    if (_formKey.currentState!.validate()) {
      _authController.register(
        _data['email']!,
        _data['password']!,
        _data['username']!,
        _data['fullName']!,
        _data['region']!,
      );
    }
  }

  void _onLoginBtnClick() {
    Get.off(() => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = Get.mediaQuery;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
              height: mediaQuery.size.height,
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
                height: mediaQuery.size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/logo_login.svg',
                      semanticsLabel: 'World Builder Logo',
                      height: mediaQuery.size.height * 0.15,
                      fit: BoxFit.scaleDown,
                    ),
                    // ignore: sized_box_for_whitespace
                    Container(
                      height: mediaQuery.size.height * .65,
                      width: mediaQuery.size.width * .85,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //ctrl+v
                            Column(
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Usuario',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  onChanged: _onFieldChanged('username'),
                                  keyboardType: TextInputType.name,
                                  validator: usernameValidator,
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
                                      'Nombre Completo',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  onChanged: _onFieldChanged('fullName'),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
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
                                      'Correo Electrónico',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  onChanged: _onFieldChanged('email'),
                                  validator: emailValidator,
                                  keyboardType: TextInputType.emailAddress,
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
                                  onChanged: _onFieldChanged('password'),
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
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
                                      'Region',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                // ignore: sized_box_for_whitespace
                                Container(
                                  width: mediaQuery.size.width,
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButton(
                                        // dropdownColor: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                        autofocus: true,
                                        elevation: 0,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                        ),
                                        value: _data['region'],
                                        items: _regions.map((Region region) {
                                          return DropdownMenuItem(
                                            value: region.code,
                                            child: Text(region.name),
                                          );
                                        }).toList(),
                                        onChanged: _onFieldChanged('region'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: mediaQuery.size.width * .85,
                      height: mediaQuery.size.height * .2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: _onSignupBtnClick,
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: const Color(0xFF92D8FF),
                                fixedSize:
                                    Size(mediaQuery.size.width * 0.4, 50)),
                            child: Text(
                              "REGISTRARSE",
                              style: GoogleFonts.play(fontSize: 18),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _onLoginBtnClick,
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                                fixedSize:
                                    Size(mediaQuery.size.width * 0.4, 50)),
                            child: Text(
                              "LOGIN",
                              style: GoogleFonts.play(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
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
