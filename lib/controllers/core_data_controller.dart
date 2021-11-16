import 'package:get/get.dart';
import 'package:world_builder/models/region.dart';
import 'package:world_builder/services/firestore_service.dart';

enum CoreDataLoadStatus { unloaded, loaded, loadedWError, loading }

abstract class CoreDataController<T> {
  abstract final String errorMessage;
  final loadStatus = Rx<CoreDataLoadStatus>(CoreDataLoadStatus.unloaded);
  late final Rx<T> data;

  Future<T> _loader();

  CoreDataController(T defaultValue) {
    data = Rx<T>(defaultValue);
  }

  void ensureInitialized() async {
    if (loadStatus.value == CoreDataLoadStatus.loaded) {
      return;
    }
    loadStatus.value = CoreDataLoadStatus.loading;
    try {
      data.value = await _loader();
      loadStatus.value = CoreDataLoadStatus.loaded;
    } catch (e) {
      loadStatus.value = CoreDataLoadStatus.loadedWError;
    }
  }
}

class RegionsController extends CoreDataController<List<Region>> {
  static const globalRegion = Region(code: 'GLOBAL', name: 'Global');
  final _store = Get.find<FirestoreService>();

  RegionsController() : super([globalRegion]);

  @override
  final String errorMessage = 'Error al cargar las regiones';

  @override
  Future<List<Region>> _loader() async {
    final _regions = (await _store.getAll('regions'))
        .docs
        .map<Region>(
          (snapshot) => Region(
            name: snapshot.data()['name'],
            code: snapshot.id,
          ),
        )
        .toList();
    _regions.sort(
      (regionA, regionB) => regionA.name.compareTo(regionB.name),
    );
    return _regions;
  }
}
