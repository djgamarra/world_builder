import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/models/club.dart';

import '../constants.dart';

class ClubPage extends StatelessWidget {
//   final _followingsController = Get.find<FollowingsController>();
//   final _userFollowingsController = FollowingsController();
//   final _userFollowersController = FollowersController();
  // final String name = "Mami";
  final Club club;

  const ClubPage({
    Key? key,
    required this.club,
  }) : super(key: key);

  void _onGoBackClick() => Get.back();

  Widget _renderMembersBox() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Miembros',
                    style: primaryFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    club.members.toString(),
                    style: primaryFont,
                  ),
                ],
              ),
            ),
          ),
        ],
      );

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Atrás',
                      onPressed: _onGoBackClick,
                      icon: const Icon(Icons.arrow_back),
                      color: defaultBorderColor,
                    ),
                    Text(
                      club.name,
                      style: primaryFont.copyWith(fontSize: 25),
                    ),
                    IconButton(
                      tooltip: 'Inivitar Miembro',
                      onPressed: () {},
                      icon: const Icon(Icons.person_add),
                      color: defaultBorderColor,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      'https://www.ecestaticos.com/imagestatic/clipping/9e1/db8/9e1db813c5cbca5aa88ac4f8bf155667/la-paranoica-foto-de-mark-zuckerberg-que-esta-dando-la-vuelta-a-internet.jpg?mtime=1622835872',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _renderMembersBox(),
                const SizedBox(height: 30),
                const SizedBox(height: 5),
                Text(
                  club.description,
                  textAlign: TextAlign.justify,
                  style: primaryFont.copyWith(
                    fontSize: 17,
                    color: defaultBorderColor,
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
