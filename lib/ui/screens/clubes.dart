import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClubesPage extends StatefulWidget {
  const ClubesPage({Key? key}) : super(key: key);

  @override
  State<ClubesPage> createState() => _ClubesPageState();
}

class _ClubesPageState extends State<ClubesPage> {
  

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
              height: mediaQuery.size.height-70,
              child: Column(children: 
              <Widget> [
                Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height*.15,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text('Clubes', style: GoogleFonts.play(fontSize: 30),),
                )
              ],) ,
            )
             )
          ,)
       
    );
  }
}
