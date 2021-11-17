import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore get store => FirebaseFirestore.instance;

  Future<void> set(String path, String? doc, Map<String, dynamic> data) =>
      store.collection(path).doc(doc).set(data);

  Future<void> delete(String path, String doc) =>
      store.collection(path).doc(doc).delete();

  Future<DocumentSnapshot<Map<String, dynamic>>> get(String path, String doc) =>
      store.collection(path).doc(doc).get();

  Future<List<T>> getDocs<T>(
    String path,
    T Function(String, Map<String, dynamic>) mapper,
  ) async =>
      (await query(path).get())
          .docs
          .map((e) => mapper(e.id, e.data()))
          .toList();

  Future<List<T>> getDocsById<T>(
    String path,
    List<String> ids,
    T Function(String, Map<String, dynamic>) mapper,
  ) async {
    var _query = query(path).where(FieldPath.documentId, whereIn: ids);
    return (await _query.get())
        .docs
        .map((e) => mapper(e.id, e.data()))
        .toList();
  }

  CollectionReference<Map<String, dynamic>> query(String path) =>
      store.collection(path);
}
