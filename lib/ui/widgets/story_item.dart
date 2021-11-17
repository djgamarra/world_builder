import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/models/story.dart';
import 'package:world_builder/ui/constants.dart';
import 'package:world_builder/ui/pages/story_page.dart';

class StoryItem extends StatelessWidget {
  final Story story;

  const StoryItem({
    Key? key,
    required this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => Get.to(StoryPage(story: story,)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                story.name,
                style: primaryFont.copyWith(fontSize: 22),
              ),
              Text(
                story.gender,
                style: primaryFont.copyWith(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
