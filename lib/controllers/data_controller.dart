import 'package:get/get.dart';

enum DataLoadStatus { unloaded, loaded, loadedWError, loading }

abstract class DataController<T> {
  abstract final String errorMessage;
  final loadStatus = Rx<DataLoadStatus>(DataLoadStatus.unloaded);
  late final Rx<T> data;

  Future<T> loader();

  DataController(T defaultValue) {
    data = Rx<T>(defaultValue);
  }

  Future<void> ensureLoaded() async {
    if (loadStatus.value == DataLoadStatus.loaded) {
      return;
    }
    await load();
  }

  Future<void> load() async {
    loadStatus.value = DataLoadStatus.loading;
    try {
      data.value = await loader();
      loadStatus.value = DataLoadStatus.loaded;
    } catch (e) {
      loadStatus.value = DataLoadStatus.loadedWError;
    }
  }
}
