import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/models/club.dart';
import 'package:world_builder/ui/constants.dart';
import 'package:world_builder/ui/pages/character_page.dart';

class CharacterItem extends StatelessWidget {
  final String name;

  const CharacterItem({
    Key? key,
    required this.name,
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
        onTap: () => Get.to(CharacterPage()),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: primaryFont.copyWith(fontSize: 17),
              ),
              Text(
                "Villano",
                style: primaryFont.copyWith(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
