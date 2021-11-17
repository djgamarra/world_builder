import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/models/club.dart';
import 'package:world_builder/models/invitation.dart';
import 'package:world_builder/services/firestore_service.dart';
import 'package:world_builder/services/users_service.dart';

class InvitationsController extends DataController<List<Invitation>> {
  final _users = Get.find<UsersService>();
  final _store = Get.find<FirestoreService>();
  StreamSubscription? _sub;

  InvitationsController() : super([]);

  @override
  void setParams(Map<String, dynamic>? params) {
    super.setParams(params);
    if (params != null && params['uid'] != null) {
      if (_sub != null) {
        _sub!.cancel().then((_) {
          _sub = _users.subscribeToInvitations(params['uid'], (_) => reload());
        });
      } else {
        _sub = _users.subscribeToInvitations(params['uid'], (_) => reload());
      }
    }
  }

  @override
  final String errorMessage = 'Error al cargar las invitaciones';

  @override
  Future<List<Invitation>> loader() async {
    final invitations = await _users.getInvitationsOf(params['uid']);
    if (invitations.isEmpty) return [];
    final invitationsMap = <String, Invitation>{};
    for (var invitation in invitations) {
      invitationsMap[invitation.clubId] = invitation;
    }
    final clubIds = invitations.map((ref) => ref.clubId).toList();
    final clubs = await _store.getDocsById(
      'clubs',
      clubIds,
      (uid, data) => Club(
        id: uid,
        ownerId: data['ownerId'] ?? '',
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        members: data['members'] ?? 0,
        gender: data['gender'] ?? '',
        name: data['name'] ?? '',
        description: data['description'] ?? '',
      ),
    );
    for (var club in clubs) {
      invitationsMap[club.id]!.club = club;
    }
    return invitationsMap.values
        .where((invitation) => invitation.club != null)
        .toList();
  }

  Future<bool> acceptInvitation(Invitation invitation) async {
    try {
      await Future.wait([
        _store.set(
          "users_public/${params['uid']}/clubs",
          invitation.clubId,
          {'createdAt': DateTime.now()},
        ),
        _store.update(
          'clubs',
          invitation.clubId,
          {'members': FieldValue.increment(1)},
        ),
        _store.delete(
          "users_public/${params['uid']}/invitations",
          invitation.clubId,
        ),
      ]);
      return true;
    } catch (e) {
      e.printError();
      return false;
    }
  }

  Future<bool> declineInvitation(Invitation invitation) async {
    try {
      await _store.delete(
        "users_public/${params['uid']}/invitations",
        invitation.clubId,
      );
      return true;
    } catch (e) {
      e.printError();
      return false;
    }
  }

  Future<bool> sendInvitation(String username, String clubId) async {
    try {
      final users = (await _store
              .query('users_public')
              .where('username', isEqualTo: username)
              .limit(1)
              .get())
          .docs;
      if (users.isNotEmpty) return true;
      final userId = users.first.id;
      await _store.set(
        "users_public/$userId/invitations",
        clubId,
        {'createdAt': DateTime.now()},
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
