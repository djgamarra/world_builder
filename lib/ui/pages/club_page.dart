import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:world_builder/controllers/data_controller.dart';
// import 'package:world_builder/controllers/followers_controller.dart';
// import 'package:world_builder/controllers/followings_controller.dart';
// import 'package:world_builder/models/user_data.dart';

import '../constants.dart';

class ClubPage extends StatelessWidget {
//   final _followingsController = Get.find<FollowingsController>();
//   final _userFollowingsController = FollowingsController();
//   final _userFollowersController = FollowersController();
  // final String name = "Mami";

  // ClubPage({
  //   Key? key,
  // }) : super(key: key) {}

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
                    "69",
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
                      "Club Gay",
                      style: primaryFont.copyWith(fontSize: 25),
                    ),
                    IconButton(
                      tooltip: 'Agregar Miembro',
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
                  "On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.",
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
