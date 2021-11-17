import 'package:get/get.dart';

enum DataLoadStatus { unloaded, loaded, loadedWError, loading }

abstract class DataController<T> {
  abstract final String errorMessage;
  final loadStatus = Rx<DataLoadStatus>(DataLoadStatus.unloaded);
  late final Rx<T> data;
  late final T _defaultValue;
  final Map<String, dynamic> params = {};

  Future<T> loader();

  DataController(T defaultValue) {
    data = Rx<T>(defaultValue);
    _defaultValue = defaultValue;
  }

  Future<void> ensureLoaded({Map<String, dynamic>? params}) async {
    if (loadStatus.value == DataLoadStatus.loaded) {
      return;
    }
    await reload(params: params);
  }

  Future<void> reload({Map<String, dynamic>? params}) async {
    this.params.addAll(params ?? {});
    loadStatus.value = DataLoadStatus.loading;
    try {
      data.value = await loader();
      loadStatus.value = DataLoadStatus.loaded;
    } catch (e) {
      print(e);
      loadStatus.value = DataLoadStatus.loadedWError;
    }
  }

  void resetData({Map<String, dynamic>? params}) {
    this.params.addAll(params ?? {});
    data.value = _defaultValue;
    loadStatus.value = DataLoadStatus.unloaded;
    params = {};
  }
}
