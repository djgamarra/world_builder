import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Center(
        child: Scaffold(
          body: SingleChildScrollView(
            // ignore: sized_box_for_whitespace
            child: Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height - 70,
              child: Column(
                children: <Widget>[
                  Container(
                    width: mediaQuery.size.width,
                    height: mediaQuery.size.height * .15,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      'Búsqueda',
                      style: GoogleFonts.play(fontSize: 30),
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
