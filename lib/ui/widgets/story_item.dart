import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/models/club.dart';
import 'package:world_builder/ui/constants.dart';
import 'package:world_builder/ui/pages/story_page.dart';

class StoryItem extends StatelessWidget {
  final String story;

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
        onTap: () => Get.to(StoryPage()),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                story,
                style: primaryFont.copyWith(fontSize: 22),
              ),
              Text(
                "Gótico",
                style: primaryFont.copyWith(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}