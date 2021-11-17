import 'package:get/get.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/models/follow_signature.dart';
import 'package:world_builder/services/users_service.dart';

class FollowersController extends DataController<Map<String, FollowSignature>> {
  final _users = Get.find<UsersService>();

  FollowersController() : super({});

  int get followingsCount => data.value.length;

  @override
  String errorMessage = 'Error al cargar la lista de seguidores';

  @override
  Future<Map<String, FollowSignature>> loader() async {
    final data = await _users.getFollowingsOf(params['uid']);
    final result = <String, FollowSignature>{};
    for (var following in data) {
      result[following.uid] = following;
    }
    return result;
  }
}
