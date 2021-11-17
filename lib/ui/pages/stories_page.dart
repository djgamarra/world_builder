import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/clubs_controller.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/ui/pages/create_story.dart';
import 'package:world_builder/ui/widgets/story_item.dart';

import '../constants.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({Key? key}) : super(key: key);

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> {
  final _clubsController = Get.find<ClubsController>();

  _StoriesPageState() {
    _clubsController.ensureLoaded();
  }

  void _onCreateBtnClick() {
    Get.to(() => const CreateStory());
  }

  var historias = ["his1", "his2"];
  Widget _renderStories() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: historias
            .map((story) => StoryItem(
                  story: story,
                ))
            .toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: defaultBorderColor,
        ),
        onPressed: _onCreateBtnClick,
        backgroundColor: const Color(0xFF9BDBFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Historias',
                  style: primaryFont.copyWith(fontSize: 25),
                ),
                const SizedBox(height: 30),
                _renderStories(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
