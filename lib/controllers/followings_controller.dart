import 'package:get/get.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/models/follow_signature.dart';
import 'package:world_builder/services/users_service.dart';

class FollowingsController
    extends DataController<Map<String, FollowSignature>> {
  final _users = Get.find<UsersService>();

  FollowingsController() : super({});

  int get count => data.value.length;

  @override
  final String errorMessage = 'Error al cargar la lista de seguidos';

  @override
  Future<Map<String, FollowSignature>> loader() async {
    final data = await _users.getFollowingsOf(params['uid']);
    final result = <String, FollowSignature>{};
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
