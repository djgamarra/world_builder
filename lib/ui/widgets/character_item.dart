import 'package:flutter/material.dart';
import 'package:world_builder/models/character.dart';
import 'package:world_builder/ui/constants.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  final Function(Character)? onCharacterDelete;

  const CharacterItem({
    Key? key,
    required this.character,
    this.onCharacterDelete,
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
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  character.name,
                  style: primaryFont.copyWith(fontSize: 17),
                ),
                Text(
                  '  como  ',
                  style: primaryFont.copyWith(
                    fontSize: 17,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  character.role,
                  style: primaryFont.copyWith(fontSize: 17),
                ),
              ],
            ),
            InkWell(
              onTap: () => onCharacterDelete == null
                  ? null
                  : onCharacterDelete!(character),
              child: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
