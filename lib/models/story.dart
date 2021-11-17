import 'package:world_builder/models/character.dart';

class Story {
  final String id, ownerId, name, gender, synopsis, place, completeStory;
  final List<Character> characters;
  final DateTime createdAt;

  const Story({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.gender,
    required this.synopsis,
    required this.place,
    required this.completeStory,
    required this.createdAt,
    required this.characters,
  });

  Map<String, dynamic> toFirestoreMap() => {
        'ownerId': ownerId,
        'name': name,
        'gender': gender,
        'synopsis': synopsis,
        'place': place,
        'completeStory': completeStory,
    'createdAt': createdAt,
        'characters': characters
            .map(
              (character) => character.toFirestoreMap(),
            )
            .toList(),
      };
}
