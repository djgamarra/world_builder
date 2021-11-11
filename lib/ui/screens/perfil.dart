import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:world_builder/ui/screens/login_screen.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

Route _createRoute() {
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

class _PerfilPageState extends State<PerfilPage> {
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
                              elevation: 0),
                          label: const Text(""),
                          onPressed: () {
                            Navigator.of(context).push(_createRoute());
                          },
                          icon:
                              const ImageIcon(AssetImage("assets/logout.png"))),
                    )
                  ],
                )),
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
                          child: Text('John Doe',
                              style: GoogleFonts.play(fontSize: 25)),
                        ))
                  ],
                )),
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
                  )),
            )
          ],
        ),
      )),
    ));
  }
}
