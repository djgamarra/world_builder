import 'package:flutter/material.dart';
import 'package:world_builder/ui/pages/create_club.dart';
import 'package:world_builder/ui/widgets/club_item.dart';
import '../constants.dart';
import 'package:get/get.dart';

const listclub = [
  "chiste",
  "chiste2",
  "auxilio",
  "mami",
  "porfavor..",
  "sacame de aqui",
  "salvame :c",
  "auxilioxd",
  "mamixd",
  "porfavor..xd",
  "sacame de xd aqui",
  "salvame xd :c"
];
Widget _renderClubResults() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listclub
          .map(
            (club) => ClubItem(
              club: club,
            ),
          )
          .toList(),
    );

class ClubsPage extends StatefulWidget {
  const ClubsPage({Key? key}) : super(key: key);

  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: defaultBorderColor,
        ),
        onPressed: () => Get.to(CreateClub()),
        backgroundColor: const Color(0xFF9BDBFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Clubes',
                  style: primaryFont.copyWith(fontSize: 25),
                ),
                const SizedBox(
                  height: 30,
                ),
                _renderClubResults(),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
