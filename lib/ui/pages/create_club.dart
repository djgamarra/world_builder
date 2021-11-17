import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/ui/pages/clubs_page.dart';
import 'package:world_builder/ui/widgets/club_item.dart';
import '../constants.dart';
import 'package:world_builder/ui/widgets/custom_text_field.dart';

class CreateClub extends StatefulWidget {
  const CreateClub({Key? key}) : super(key: key);

  @override
  State<CreateClub> createState() => _CreateClubState();
}

class _CreateClubState extends State<CreateClub> {
  void _onSaveBtnClick() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.save,
          color: defaultBorderColor,
        ),
        onPressed: _onSaveBtnClick,
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
                  'Crea tu club!',
                  style: primaryFont.copyWith(fontSize: 25),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Nombre de club:",
                  style: primaryFont.copyWith(fontSize: 17),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  onChanged: (_, __) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Género:",
                  style: primaryFont.copyWith(fontSize: 17),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  onChanged: (_, __) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Descripción:",
                  style: primaryFont.copyWith(fontSize: 17),
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  type: TextInputType.multiline,
                  onChanged: (_, __) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
