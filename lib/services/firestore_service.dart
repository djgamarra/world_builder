import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore get store => FirebaseFirestore.instance;

  Future<void> set(String path, String doc, Map<String, dynamic> data) =>
      store.collection(path).doc(doc).set(data);

  Future<void> delete(String path, String doc) =>
      store.collection(path).doc(doc).delete();

  Future<DocumentSnapshot<Map<String, dynamic>>> get(String path, String doc) =>
      store.collection(path).doc(doc).get();

  Future<QuerySnapshot<Map<String, dynamic>>> getAll(String path) =>
      store.collection(path).get();

  Future<List<T>> getDocs<T>(
          String path, T Function(String, Map<String, dynamic>) mapper) async =>
      (await query(path).get())
          .docs
          .map((e) => mapper(e.id, e.data()))
          .toList();

  CollectionReference<Map<String, dynamic>> query(String path) =>
      store.collection(path);
}
