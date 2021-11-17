import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/models/story.dart';
import 'package:world_builder/ui/pages/fullstory_page.dart';
import 'package:world_builder/ui/widgets/character_item.dart';
import 'package:world_builder/ui/widgets/custom_button.dart';

// import 'package:world_builder/controllers/data_controller.dart';
// import 'package:world_builder/controllers/followers_controller.dart';
// import 'package:world_builder/controllers/followings_controller.dart';
// import 'package:world_builder/models/user_data.dart';

import '../constants.dart';

class StoryPage extends StatelessWidget {
//   final _followingsController = Get.find<FollowingsController>();
//   final _userFollowingsController = FollowingsController();
//   final _userFollowersController = FollowersController();
  // final String name = "Mami";
  final Story story;

  const StoryPage({
    Key? key,
    required this.story,
  }) : super(key: key);

  Widget _renderCharacters() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: story.characters
            .map((character) => CharacterItem(character: character))
            .toList(),
      );

  void _onGoBackClick() => Get.back();

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
                      story.name,
                      style: primaryFont.copyWith(fontSize: 25),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      'https://i.pinimg.com/originals/b2/09/ec/b209eccf906f55e4ee53ce9a0739bb72.png',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Sinopsis',
                  textAlign: TextAlign.start,
                  style: primaryFont.copyWith(
                    fontSize: 18,
                    color: defaultBorderColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  story.synopsis,
                  textAlign: TextAlign.justify,
                  style: primaryFont.copyWith(
                    fontSize: 17,
                    color: defaultBorderColor,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    backgroundColor: defaultBorderColor,
                    color: Colors.white,
                    text: "Ver historia completa",
                    onClick: () => Get.to(() => FullStoryPage(story: story)),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Personajes',
                  textAlign: TextAlign.start,
                  style: primaryFont.copyWith(
                    fontSize: 18,
                    color: defaultBorderColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _renderCharacters(),
                const SizedBox(height: 30),
                Text(
                  'Lugar principal',
                  textAlign: TextAlign.start,
                  style: primaryFont.copyWith(
                    fontSize: 18,
                    color: defaultBorderColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  story.place,
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
