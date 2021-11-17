import 'package:get/get.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/models/club.dart';
import 'package:world_builder/services/users_service.dart';

class ClubsController extends DataController<List<Club>> {
  final _users = Get.find<UsersService>();

  ClubsController() : super([]);

  @override
  final String errorMessage = 'Error al cargar tus clubes';

  @override
  Future<List<Club>> loader() => _users.getClubsOf(params['uid']);
}
