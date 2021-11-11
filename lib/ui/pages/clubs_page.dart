import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({Key? key}) : super(key: key);

  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
        backgroundColor: Color(0xFF9BDBFF),
      ),
      body: Center(
        child: Scaffold(
          body:
              // ignore: sized_box_for_whitespace
              Container(
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
                    'Clubes',
                    style: GoogleFonts.play(fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
