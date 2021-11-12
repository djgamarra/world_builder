import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:world_builder/controllers/users_controller.dart';
import 'package:world_builder/ui/widgets/custom_button.dart';
import 'package:world_builder/ui/widgets/custom_text_field.dart';

import '../constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _usersController = Get.find<UsersController>();
  String _searchText = '';
  List<Map<String, dynamic>> _data = [];

  void _onSearchQChanged(_, text) => setState(() {
        _searchText = text;
      });

  void _onSearchBtnClick() async {
    Get.focusScope!.unfocus();
    final data = await _usersController.searchUsers(_searchText);
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buscar usuario',
                  style: primaryFont.copyWith(fontSize: 30),
                ),
                CustomTextField(
                  onChanged: _onSearchQChanged,
                ),
                CustomButton(
                  text: 'BUSCAR',
                  onClick: _onSearchBtnClick,
                  solid: true,
                ),
                ..._data.map((e) => Text(e['username'])).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
