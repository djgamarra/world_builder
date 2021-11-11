import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/ui/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _authController = Get.find<AuthController>();

  _ProfilePageState() {
    _authController.currentStatus.listen((status) {
      if (status == AuthStatus.loggedOut) {
        Get.off(() => const LoginPage());
      }
    });
  }

  void _onLogoutBtnClick() {
    _authController.logout();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Center(
        child: Scaffold(
          body: SingleChildScrollView(
            // ignore: sized_box_for_whitespace
            child: SafeArea(
              child: Container(
                height: mediaQuery.size.height - 100,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Perfil',
                            style: GoogleFonts.play(fontSize: 30),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black,
                              elevation: 0,
                            ),
                            label: const Text(""),
                            onPressed: _onLogoutBtnClick,
                            icon: const ImageIcon(
                              AssetImage("assets/logout.png"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const ImageIcon(
                            AssetImage("assets/Ellipse.png"),
                            size: 70,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                            child: Text(
                              'John Doe',
                              style: GoogleFonts.play(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Nombre Real',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.solid,
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
                                    'Gustos Literarios',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.solid,
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
                                    'Intereses',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.solid,
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
                                    'Tipo de literatura que escribo',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ],
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
