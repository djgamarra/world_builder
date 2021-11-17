import 'package:get/get.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/models/character.dart';
import 'package:world_builder/models/story.dart';
import 'package:world_builder/services/firestore_service.dart';
import 'package:world_builder/services/users_service.dart';

class StoriesController extends DataController<List<Story>> {
  final _users = Get.find<UsersService>();
  final _store = Get.find<FirestoreService>();

  StoriesController() : super([]);

  @override
  final String errorMessage = 'Error al cargar las historias';

  @override
  Future<List<Story>> loader() => _users.getStoriesCreatedBy(params['uid']);

  Future<bool> createStory(
    String uid,
    String name,
    String gender,
    String synopsis,
    String place,
    String completeStory,
    List<Character> characters,
      [String? doc,]
  ) async {
    final story = Story(
      id: '',
      ownerId: uid,
      name: name,
      gender: gender,
      synopsis: synopsis,
      place: place,
      completeStory: completeStory,
      characters: characters,
      createdAt: DateTime.now(),
    );
    try {
      await _store.set('stories', doc, story.toFirestoreMap());
      return true;
    } catch (e) {
      e.printError();
      return false;
    }
  }
}
