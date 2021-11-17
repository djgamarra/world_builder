import 'package:world_builder/models/club.dart';

class Invitation {
  final String clubId;
  final DateTime createdAt;
  Club? club;

  Invitation({
    required this.clubId,
    required this.createdAt,
    this.club,
  });
}
