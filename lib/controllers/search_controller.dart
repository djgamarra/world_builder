import 'package:get/get.dart';
import 'package:world_builder/models/user_data.dart';
import 'package:world_builder/services/users_service.dart';

import 'data_controller.dart';

class SearchController extends DataController<List<ExternalUserData>> {
  final _users = Get.find<UsersService>();

  SearchController() : super([]);

  @override
  final errorMessage = 'Error al realizar la búsqueda';

  @override
  Future<List<ExternalUserData>> loader() => _users.searchUsers(
        params['query'],
        region: params['user'].region,
      );
}
