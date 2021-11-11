import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoriasPage extends StatefulWidget {
  const HistoriasPage({Key? key}) : super(key: key);

  @override
  State<HistoriasPage> createState() => _HistoriasPageState();
}

class _HistoriasPageState extends State<HistoriasPage> {
  

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
                  child: Text('Tus Historias', style: GoogleFonts.play(fontSize: 30),),
                )
              ],) ,
            )
             )
          ,)
       
    );
  }
}
