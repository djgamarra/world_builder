import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore get store => FirebaseFirestore.instance;

  Future<void> set(String path, String doc, Map<String, dynamic> data) =>
      store.collection(path).doc(doc).set(data);

  Future<void> get(String path, String doc) =>
      store.collection(path).doc(doc).get();
}
