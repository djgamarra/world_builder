import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/ui/screens/homepage.dart';
import 'package:world_builder/ui/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

Route _createRouteLogIn() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const LoginScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}

Route _createRouteTwo() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}

// Text controllers
final name = TextEditingController();
final username = TextEditingController();
final email = TextEditingController();
final password = TextEditingController();
final passwordver = TextEditingController();

bool _validate = false;

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _data = {
    'username': '',
    'fullName': '',
    'email': '',
    'password': '',
    'region': '',
  };

  _onFieldChanged(String key) => (text) => setState(() {
        _data[key] = text ?? '';
      });

  void _onSignupBtnClick() {
    if (_formKey.currentState!.validate()) {
      Get.find<AuthController>().register(
        _data['email']!,
        _data['password']!,
        _data['username']!,
        _data['fullName']!,
        _data['region']!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String dropdownvalue = 'Region1';
    var regions = ['Region1', 'Region2', 'Region3'];
    const String logoUrl = 'assets/logo_login.svg';
    final mediaQuery = MediaQuery.of(context);

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
                      logoUrl,
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
                                  controller: username,
                                  decoration: InputDecoration(
                                    errorText: _validate
                                        ? "Debe ingresar un valor válido."
                                        : null,
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
                                  controller: name,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    errorText: _validate
                                        ? "Debe ingresar un valor válido."
                                        : null,
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
                                  controller: email,
                                  decoration: InputDecoration(
                                    errorText: _validate
                                        ? "Debe ingresar un valor válido."
                                        : null,
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
                                  controller: password,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    errorText: _validate
                                        ? "Debe ingresar un valor válido."
                                        : null,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: passwordver,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    errorText: _validate
                                        ? "Debe ingresar un valor válido."
                                        : null,
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
                                        dropdownColor: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                        autofocus: true,
                                        elevation: 0,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                        ),
                                        value: dropdownvalue,
                                        items: regions.map((String regions) {
                                          return DropdownMenuItem(
                                            value: regions,
                                            child: Text(regions),
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
                            onPressed: () => {
                              if (username.text.isEmpty ||
                                  name.text.isEmpty ||
                                  email.text.isEmpty ||
                                  password.text.isEmpty ||
                                  passwordver.text.isEmpty)
                                {
                                  _validate = true,
                                  Navigator.of(context)
                                      .push(_createRouteLogIn())
                                }
                              else
                                {_validate = false},
                            },
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
                            onPressed: () {
                              Navigator.of(context).push(_createRouteTwo());
                            },
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
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.white,
                              fixedSize: Size(mediaQuery.size.width * 0.4, 50),
                            ),
                            child: Text(
                              "LOGIN",
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
      ),
    );
  }
}
