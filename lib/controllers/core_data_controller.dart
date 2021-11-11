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
    try {
      final _regions = (await _store.getAll('regions'))
          .docs
          .map<String>((snapshot) => snapshot.data()['name'])
          .toList();
      _regions.sort();
      regions.value = _regions;
    } catch (_) {
      regions.value = ['GLOBAL'];
    }
  }
}
