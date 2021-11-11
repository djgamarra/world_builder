import 'package:get/get.dart';
import 'package:world_builder/models/region.dart';
import 'package:world_builder/services/firestore_service.dart';

class CoreDataController {
  static const globalRegion = Region(code: 'GLOBAL', name: 'Global');
  final regions = Rx<List<Region>>([globalRegion]);

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
          .map<Region>((snapshot) => Region(
                name: snapshot.data()['name'],
                code: snapshot.id,
              ))
          .toList();
      _regions.sort((regionA, regionB) => regionA.name.compareTo(regionB.name));
      regions.value = _regions;
    } catch (_) {
      regions.value = [globalRegion];
    }
  }
}
