import 'dart:async';

import 'package:get/get.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/models/user_signature.dart';
import 'package:world_builder/services/users_service.dart';

class FollowersController extends DataController<Map<String, UserSignature>> {
  final _users = Get.find<UsersService>();
  StreamSubscription? _sub;

  FollowersController() : super({});

  int get count => data.value.length;

  @override
  void setParams(Map<String, dynamic>? params) {
    super.setParams(params);
    if (params != null && params['uid'] != null) {
      if (_sub != null) {
        _sub!.cancel().then((_) {
          _sub = _users.subscribeToFollowers(params['uid'], (_) => reload());
        });
      } else {
        _sub = _users.subscribeToFollowers(params['uid'], (_) => reload());
      }
    }
  }

  @override
  String errorMessage = 'Error al cargar la lista de seguidores';

  @override
  Future<Map<String, UserSignature>> loader() async {
    final data = await _users.getFollowersOf(params['uid']);
    final result = <String, UserSignature>{};
    for (var following in data) {
      result[following.uid] = following;
    }
    return result;
  }
}
