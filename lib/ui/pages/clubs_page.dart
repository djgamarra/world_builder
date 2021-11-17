import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/clubs_controller.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/ui/widgets/club_item.dart';

import '../constants.dart';
import 'create_club.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({Key? key}) : super(key: key);

  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  final _clubsController = Get.find<ClubsController>();

  _ClubsPageState() {
    _clubsController.ensureLoaded();
  }

  void _onCreateBtnClick() => Get.to(() => const CreateClub());

  Widget _renderClubResults() => Obx(() {
        switch (_clubsController.loadStatus.value) {
          case DataLoadStatus.loaded:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _clubsController.data.value
                  .map((club) => ClubItem(
                        club: club,
                      ))
                  .toList(),
            );
          default:
            return Text(
              'Cargando...',
              style: primaryFont.copyWith(fontSize: 17),
            );
        }
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: defaultBorderColor,
        ),
        onPressed: _onCreateBtnClick,
        backgroundColor: const Color(0xFF9BDBFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clubes',
                  style: primaryFont.copyWith(fontSize: 25),
                ),
                const SizedBox(height: 30),
                _renderClubResults(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
