import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/models/club.dart';

class ClubsController extends DataController<List<Club>> {
  ClubsController() : super([]);

  @override
  final String errorMessage = 'Error al cargar tus clubes';

  @override
  Future<List<Club>> loader() {
    // TODO: implement loader
    throw UnimplementedError();
  }
}
