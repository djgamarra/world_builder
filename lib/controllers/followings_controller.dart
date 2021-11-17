import 'dart:async';

import 'package:get/get.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/models/reference.dart';
import 'package:world_builder/services/users_service.dart';

class FollowingsController extends DataController<Map<String, Reference>> {
  final _users = Get.find<UsersService>();
  // StreamSubscription? _sub;

  FollowingsController() : super({});

  // @override
  // void setParams(Map<String, dynamic>? params) {
  //   super.setParams(params);
  //   if (params != null && params['uid'] != null) {
  //     if (_sub != null) {
  //       _sub!.cancel().then((_) {
  //         _sub = _users.subscribeToFollowings(params['uid'], (_) => reload());
  //       });
  //     } else {
  //       _sub = _users.subscribeToFollowings(params['uid'], (_) => reload());
  //     }
  //   }
  // }

  @override
  final String errorMessage = 'Error al cargar la lista de seguidos';

  @override
  Future<Map<String, Reference>> loader() async {
    final data = await _users.getFollowingsOf(params['uid']);
    final result = <String, Reference>{};
    for (var following in data) {
      result[following.uid] = following;
    }
    return result;
  }

  Future<bool> startFollowing(String uid) async {
    try {
      await _users.startFollowing(params['uid'], uid);
      await reload();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> stopFollowing(String uid) async {
    try {
      await _users.stopFollowing(params['uid'], uid);
      await reload();
      return true;
    } catch (e) {
      return false;
    }
  }
}
