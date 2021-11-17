import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:world_builder/models/character.dart';
import 'package:world_builder/models/club.dart';
import 'package:world_builder/models/invitation.dart';
import 'package:world_builder/models/reference.dart';
import 'package:world_builder/models/story.dart';
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

  Future<List<ExternalUserData>> searchUsers(
    String searchText, {
    required String region,
  }) async {
    var query = _store.query('users_public').where('region', isEqualTo: region);
    searchText.split('').toSet().forEach((char) {
      query = query.where("usernameIndex.$char", isEqualTo: true);
    });
    return (await query.limit(10).get()).docs.map((e) {
      final data = e.data();
      return ExternalUserData(
        uid: e.id,
        username: data['username'] ?? '',
        taste: data['taste'] ?? '',
        interests: data['interests'] ?? '',
        writerOf: data['writerOf'] ?? '',
        region: data['region'] ?? '',
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

  Future<List<Reference>> getFollowersOf(String uid) => _store.getDocs(
        "users_public/$uid/followers",
        (uid, data) => Reference(
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          uid: uid,
        ),
      );

  Future<List<Reference>> getFollowingsOf(String uid) => _store.getDocs(
        "users_public/$uid/followings",
        (uid, data) => Reference(
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          uid: uid,
        ),
      );

  Future<List<Reference>> getClubsOf(String uid) => _store.getDocs(
        "users_public/$uid/clubs",
        (uid, data) => Reference(
          uid: uid,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
        ),
      );

  Future<List<Invitation>> getInvitationsOf(String uid) => _store.getDocs(
        "users_public/$uid/invitations",
        (id, data) => Invitation(
          clubId: id,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
        ),
      );

  Future<List<Club>> getClubsCreatedBy(String uid) async => (await _store
              .query('clubs')
              .where('ownerId', isEqualTo: uid)
              .orderBy('createdAt', descending: true)
              .get())
          .docs
          .map((doc) {
        final data = doc.data();
        return Club(
          id: doc.id,
          ownerId: data['ownerId'] ?? '',
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          gender: data['gender'] ?? '',
          members: data['members'] ?? 0,
        );
      }).toList();

  Future<List<Story>> getStoriesCreatedBy(String uid) async => (await _store
              .query('stories')
              .where('ownerId', isEqualTo: uid)
              .orderBy('createdAt', descending: true)
              .get())
          .docs
          .map((doc) {
        final data = doc.data();
        return Story(
          id: doc.id,
          name: data['name'] ?? '',
          gender: data['gender'] ?? '',
          completeStory: data['completeStory'] ?? '',
          ownerId: data['ownerId'] ?? '',
          place: data['place'] ?? '',
          synopsis: data['synopsis'] ?? '',
          characters: ((data['characters'] ?? []) as List<Map<String, dynamic>>)
              .map(
                (character) => Character(
                  name: character['name'],
                  role: character['role'],
                ),
              )
              .toList(),
        );
      }).toList();

  Future<void> startFollowing(String from, String to) async {
    final d = DateTime.now();
    await Future.wait([
      _store.set("users_public/$from/followings", to, {'createdAt': d}),
      _store.set("users_public/$to/followers", from, {'createdAt': d}),
    ]);
  }

  Future<void> stopFollowing(String from, String to) async {
    await Future.wait([
      _store.delete("users_public/$from/followings", to),
      _store.delete("users_public/$to/followers", from),
    ]);
  }

  StreamSubscription subscribeToFollowers(
          String uid, Function(QuerySnapshot) func) =>
      _store.query("users_public/$uid/followers").snapshots().listen(func);

  StreamSubscription subscribeToInvitations(
          String uid, Function(QuerySnapshot) func) =>
      _store.query("users_public/$uid/invitations").snapshots().listen(func);
}
