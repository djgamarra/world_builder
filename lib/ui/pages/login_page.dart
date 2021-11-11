import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:world_builder/controllers/users_controller.dart';
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
  final _authController = Get.find<UsersController>();

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _data = {
    'email': '',
    'password': '',
  };

  _LoginPageState() {
    _authController.errorMessage.listen((errorMessage) {
      if (errorMessage != null) {
        Get.snackbar('Error', errorMessage);
      }
    });
    _authController.currentStatus.listen((authStatus) {
      if (authStatus == AuthStatus.loggedIn) {
        Get.off(() => const HomePage());
      }
    });
  }

  void _onFieldChanged(String field, String value) => setState(() {
        _data[field] = value;
      });

  void _onLoginBtnClick() {
    if (_formKey.currentState!.validate()) {
      Get.find<UsersController>().login(
        _data['email']!,
        _data['password']!,
      );
    }
  }

  void _onRegisterBtnClick() => Get.off(() => const SignupPage());

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
          // alignment: Alignment.bottomCenter,
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
                  Row(
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
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Container(
    //       alignment: Alignment.bottomCenter,
    //       height: mediaQuery.size.height,
    //       width: mediaQuery.size.width,
    //       decoration: const BoxDecoration(
    //         image: DecorationImage(
    //           image: AssetImage("assets/background.jpg"),
    //           fit: BoxFit.fill,
    //         ),
    //       ),
    //       child: Padding(
    //         padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    //         child: Container(
    //           height: mediaQuery.size.height * .7,
    //           width: double.infinity,
    //           decoration: const BoxDecoration(
    //             color: Color(0xAACCDDE7),
    //             borderRadius: BorderRadius.only(
    //               topRight: Radius.circular(15),
    //               topLeft: Radius.circular(15),
    //             ),
    //           ),
    //           child: Column(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(20),
    //                 child: SvgPicture.asset(
    //                   'assets/logo_login.svg',
    //                   semanticsLabel: 'World Builder Logo',
    //                   fit: BoxFit.scaleDown,
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(15),
    //                 child: CustomTextField(
    //                   label: 'Correo electrónico',
    //                   onChanged: (a, b) {},
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.all(15),
    //                 child: CustomTextField(
    //                   label: 'Contraseña',
    //                   onChanged: (a, b) {},
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    // const String logoUrl = 'assets/logo_login.svg';
    // final mediaQuery = MediaQuery.of(context);
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Form(
    //       key: _formKey,
    //       child: Container(
    //         alignment: Alignment.bottomCenter,
    //         height: mediaQuery.size.height,
    //         width: mediaQuery.size.width,
    //         decoration: const BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage("assets/background.jpg"),
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    //         child: Container(
    //           height: mediaQuery.size.height * .7,
    //           width: mediaQuery.size.width,
    //           decoration: const BoxDecoration(
    //             color: Color(0xAACCDDE7),
    //             borderRadius: BorderRadius.only(
    //               topRight: Radius.circular(15),
    //               topLeft: Radius.circular(15),
    //             ),
    //           ),
    //           // ignore: sized_box_for_whitespace
    //           child: Container(
    //             width: mediaQuery.size.width * .85,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: <Widget>[
    //                 SvgPicture.asset(
    //                   logoUrl,
    //                   semanticsLabel: 'World Builder Logo',
    //                   fit: BoxFit.scaleDown,
    //                 ),
    //                 // ignore: sized_box_for_whitespace
    //                 Container(
    //                   width: mediaQuery.size.width * .85,
    //                   height: mediaQuery.size.height * .5,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     children: <Widget>[
    //                       // Column(
    //                       //   children: <Widget>[
    //                       //     const Padding(
    //                       //       padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
    //                       //       child: Align(
    //                       //         alignment: Alignment.centerLeft,
    //                       //         child: Text(
    //                       //           'Correo electrónico',
    //                       //           style: TextStyle(fontSize: 16),
    //                       //         ),
    //                       //       ),
    //                       //     ),
    //                       //     TextFormField(
    //                       //       keyboardType: TextInputType.emailAddress,
    //                       //       onChanged: _onFieldChanged('email'),
    //                       //       validator: emailValidator,
    //                       //       decoration: InputDecoration(
    //                       //         border: OutlineInputBorder(
    //                       //           borderRadius: BorderRadius.circular(10),
    //                       //           borderSide: const BorderSide(
    //                       //             width: 0,
    //                       //             style: BorderStyle.none,
    //                       //           ),
    //                       //         ),
    //                       //         filled: true,
    //                       //         fillColor: Colors.white,
    //                       //       ),
    //                       //     ),
    //                       //   ],
    //                       // ),
    //                       Column(
    //                         children: <Widget>[
    //                           const Padding(
    //                             padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
    //                             child: Align(
    //                               alignment: Alignment.centerLeft,
    //                               child: Text(
    //                                 'Contraseña',
    //                                 style: TextStyle(fontSize: 16),
    //                               ),
    //                             ),
    //                           ),
    //                           CustomTextField(),
    //                           CustomTextField(),
    //                           // TextFormField(
    //                           //   keyboardType: TextInputType.visiblePassword,
    //                           //   obscureText: true,
    //                           //   onChanged: _onFieldChanged('password'),
    //                           //   validator: passwordValidator,
    //                           //   decoration: InputDecoration(
    //                           //     border: OutlineInputBorder(
    //                           //       borderRadius: BorderRadius.circular(10),
    //                           //       borderSide: const BorderSide(
    //                           //         width: 0,
    //                           //         style: BorderStyle.none,
    //                           //       ),
    //                           //     ),
    //                           //     filled: true,
    //                           //     fillColor: Colors.white,
    //                           //   ),
    //                           // ),
    //                         ],
    //                       ),
    //                       ElevatedButton(
    //                         onPressed: _onLoginBtnClick,
    //                         style: ElevatedButton.styleFrom(
    //                           elevation: 0,
    //                           primary: const Color(0xFF92D8FF),
    //                           fixedSize: Size(mediaQuery.size.width * 0.4, 50),
    //                         ),
    //                         child: Text(
    //                           "LOGIN",
    //                           style: GoogleFonts.play(fontSize: 18),
    //                         ),
    //                       ),
    //                       ElevatedButton(
    //                         onPressed: _onRegisterBtnClick,
    //                         style: ElevatedButton.styleFrom(
    //                           elevation: 0,
    //                           primary: Colors.white,
    //                           fixedSize: Size(mediaQuery.size.width * 0.4, 50),
    //                         ),
    //                         child: Text(
    //                           "REGISTRO",
    //                           style: GoogleFonts.play(fontSize: 18),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
