import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/models/club.dart';
import 'package:world_builder/services/firestore_service.dart';
import 'package:world_builder/services/users_service.dart';

class ClubsController extends DataController<List<Club>> {
  final _users = Get.find<UsersService>();
  final _store = Get.find<FirestoreService>();

  ClubsController() : super([]);

  @override
  final String errorMessage = 'Error al cargar tus clubes';

  @override
  Future<List<Club>> loader() async {
    final clubsMap = <String, Club>{};
    for (var club in (await _users.getClubsCreatedBy(params['uid']))) {
      clubsMap[club.id] = club;
    }
    final clubs =
        (await _users.getClubsOf(params['uid'])).map((ref) => ref.uid).toList();
    if (clubs.isNotEmpty) {
      for (var club in (await _store.getDocsById(
        'clubs',
        clubs,
        (uid, data) => Club(
          id: uid,
          ownerId: data['ownerId'] ?? '',
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          members: data['members'] ?? 0,
          gender: data['gender'] ?? '',
          name: data['name'] ?? '',
          description: data['description'] ?? '',
        ),
      ))) {
        clubsMap[club.id] = club;
      }
    }
    return clubsMap.values.toList();
  }

  Future<bool> createClub({
    required String uid,
    required String name,
    required String gender,
    required String description,
  }) async {
    final club = Club(
      id: '',
      ownerId: uid,
      createdAt: DateTime.now(),
      name: name,
      description: description,
      gender: gender,
      members: 0,
    );
    try {
      _store.set('clubs', null, club.toFirestoreMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
