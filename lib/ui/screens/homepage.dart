import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:world_builder/ui/screens/busqueda.dart';
import 'package:world_builder/ui/screens/clubes.dart';
import 'package:world_builder/ui/screens/historias.dart';
import 'package:world_builder/ui/screens/login_screen.dart';
import 'package:world_builder/ui/screens/perfil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HistoriasPage(),
    ClubesPage(),
    BusquedaPage(),
    PerfilPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
       bottomNavigationBar: 
        Theme(
         data:Theme.of(context).copyWith(
        canvasColor: const Color(0xFFE1F4FF),
        ),
        child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/Historias.png")),
            label: 'Historias',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/grupo-de-chat.png")),
            label: 'Clubes',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/vidrio-de-aumento.png")),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/usuario-de-perfil.png")),
            label: 'Perfil',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        selectedIconTheme: const IconThemeData(size: 40, color: Colors.black),
        unselectedIconTheme: const IconThemeData(size:20, color: Colors.black),
        unselectedLabelStyle: GoogleFonts.play(fontSize: 14),
        showSelectedLabels: false,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),)
       
    );
  }
}
