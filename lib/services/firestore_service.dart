import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore get store => FirebaseFirestore.instance;

  Future<void> set(String path, String doc, Map<String, dynamic> data) =>
      store.collection(path).doc(doc).set(data);

  Future<DocumentSnapshot<Map<String, dynamic>>> get(String path, String doc) =>
      store.collection(path).doc(doc).get();

  Future<QuerySnapshot<Map<String, dynamic>>> getAll(String path) async =>
      store.collection(path).get();
}
