import 'package:get/get.dart';
import 'package:world_builder/models/user_data.dart';
import 'package:world_builder/services/users_service.dart';

import 'data_controller.dart';

class SearchController extends DataController<List<ExternalUserData>> {
  final _users = Get.find<UsersService>();
  String _query = '';
  UserData? _user;

  SearchController() : super([]);

  @override
  final errorMessage = 'Error al realizar la búsqueda';

  @override
  Future<List<ExternalUserData>> loader() => _users.searchUsers(
        _query,
        region: _user!.region,
      );

  Future<void> searchOver(String query, UserData user) async {
    _query = query;
    _user = user;
    await load();
  }
}
