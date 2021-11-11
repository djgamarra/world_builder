import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:world_builder/ui/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _onLogoutBtnClick() {
    Get.off(() => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Center(
        child: Scaffold(
          body:
              // ignore: sized_box_for_whitespace
              Container(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height - 70,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height * .13,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        width: mediaQuery.size.width * .5 - 20,
                        height: mediaQuery.size.height * .13,
                        child: Text(
                          'Perfil',
                          style: GoogleFonts.play(fontSize: 30),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: mediaQuery.size.width * .5 - 20,
                        height: mediaQuery.size.height * .13,
                        child: ElevatedButton.icon(
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
                      )
                    ],
                  ),
                ),
                Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height * .15,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: mediaQuery.size.width * .5 - 20,
                        height: mediaQuery.size.height * .6,
                        // no se subirle el tamaño a esto?
                        child: const ImageIcon(
                          AssetImage("assets/Ellipse.png"),
                          size: 200,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: mediaQuery.size.width * .5 - 20,
                        height: mediaQuery.size.height * .15,
                        // ignore: avoid_unnecessary_containers
                        child: Container(
                          child: Text(
                            'John Doe',
                            style: GoogleFonts.play(fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: mediaQuery.size.width * .9,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
