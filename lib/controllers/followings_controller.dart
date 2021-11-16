import 'package:get/get.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/models/user_data.dart';
import 'package:world_builder/services/users_service.dart';

class FollowingsController extends DataController<List<ExternalUserData>> {
  final _users = Get.find<UsersService>();
  String? uid;

  FollowingsController() : super([]);

  @override
  final String errorMessage = 'Error al cargar la lista de seguidores';

  @override
  Future<List<ExternalUserData>> loader() async {

  }
}
