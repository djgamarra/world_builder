import 'package:get/get.dart';
import 'package:world_builder/services/firestore_service.dart';

class CoreDataController {
  final regions = Rx<List<String>>([]);

  late final FirestoreService _store;

  CoreDataController({
    required FirestoreService firestoreService,
  }) {
    _store = firestoreService;
  }

  Future<void> init() async {
    final query = await _store.getAll('regions');
    final _regions =
        query.docs.map<String>((snapshot) => snapshot.data()['name']).toList();
    _regions.sort();
    regions.value = _regions;
  }
}
