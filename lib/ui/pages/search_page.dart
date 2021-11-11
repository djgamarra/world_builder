import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = '';

  void _onSearchQChanged(text) => setState(() {
        searchText = text;
      });

  void _onSearchBtnClick() {}

  @override
  Widget build(BuildContext context) {
    final mediaQuery = Get.mediaQuery;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Text(
                'Búsqueda',
                style: GoogleFonts.play(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                onChanged: _onSearchQChanged,
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
            ),
            ElevatedButton(
              onPressed: _onSearchBtnClick,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: const Color(0xFF92D8FF),
                fixedSize: Size(mediaQuery.size.width * 0.4, 50),
              ),
              child: Text(
                "BUSCAR",
                style: GoogleFonts.play(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
