import 'package:get/get.dart';
import 'package:world_builder/models/region.dart';
import 'package:world_builder/services/firestore_service.dart';

import 'data_controller.dart';

class RegionsController extends DataController<List<Region>> {
  static const globalRegion = Region(code: 'GLOBAL', name: 'Global');
  final _store = Get.find<FirestoreService>();

  RegionsController() : super([globalRegion]);

  @override
  final String errorMessage = 'Error al cargar las regiones';

  @override
  Future<List<Region>> loader() async {
    final _regions = await _store.getDocs(
      'regions',
      (id, data) => Region(
        name: data['name'],
        code: id,
      ),
    );
    _regions.sort(
      (regionA, regionB) => regionA.name.compareTo(regionB.name),
    );
    return _regions;
  }
}
