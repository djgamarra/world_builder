import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:world_builder/models/user_data.dart';
import 'package:world_builder/services/firestore_service.dart';

class UsersService {
  final _store = Get.find<FirestoreService>();

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getUserData(
          String uid) =>
      Future.wait([
        _store.get('users_private', uid),
        _store.get('users_public', uid),
      ]);

  Future<List<void>> setUserData(UserData user) => Future.wait([
        _store.set(
          'users_private',
          user.uid,
          user.toFirestoreMapPrivate(),
        ),
        _store.set(
          'users_public',
          user.uid,
          user.toFirestoreMapPublic(),
        ),
      ]);

  Future<List<ExternalUserData>> searchUsers(String searchText,
      {required String region}) async {
    var query = _store.query('users_public').where('region', isEqualTo: region);
    searchText.split('').toSet().forEach((char) {
      query = query.where("usernameIndex.$char", isEqualTo: true);
    });
    return (await query.limit(10).get()).docs.map<ExternalUserData>((e) {
      final data = e.data();
      return ExternalUserData(
        username: data['username']!,
        taste: data['taste']!,
        interests: data['interests']!,
        writerOf: data['writerOf']!,
        region: data['region']!,
      );
    }).toList();
  }

  Future<UserData> updateProfile(
    String fullName,
    String taste,
    String interests,
    String writerOf,
    UserData user,
  ) async {
    final newUserData = UserData(
      uid: user.uid,
      email: user.email,
      username: user.username,
      fullName: fullName,
      region: user.region,
      user: user.user,
      taste: taste,
      interests: interests,
      writerOf: writerOf,
    );
    try {
      await setUserData(newUserData);
      return newUserData;
    } catch (_) {
      return user;
    }
  }
}
