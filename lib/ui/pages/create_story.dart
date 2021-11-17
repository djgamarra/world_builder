import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/controllers/clubs_controller.dart';
import 'package:world_builder/ui/utils.dart';
import 'package:world_builder/ui/widgets/custom_text_field.dart';
import 'package:world_builder/ui/widgets/character_item.dart';

import '../constants.dart';

class CreateStory extends StatefulWidget {
  const CreateStory({Key? key}) : super(key: key);

  @override
  State<CreateStory> createState() => _CreateStoryState();
}

class _CreateStoryState extends State<CreateStory> {
  // final _clubsController = Get.find<ClubsController>();
  // final _authController = Get.find<AuthController>();
  // final _formKey = GlobalKey<FormState>();
  // final _data = <String, String>{
  //   'name': '',
  //   'gender': '',
  //   'description': '',
  // };

  // void _onFieldChanged(String field, String value) => setState(() {
  //       _data[field] = value;
  //     });

  void _onSaveBtnClick() async {
    // if (_formKey.currentState!.validate()) {
    //   Get.focusScope!.unfocus();
    //   final status = _authController.currentStatus.value as AuthOkStatus;
    //   await _clubsController.createClub(
    //     uid: status.userData.uid,
    //     name: _data['name']!,
    //     gender: _data['gender']!,
    //     description: _data['description']!,
    //   );
    //   _clubsController.reload();
    //   Get.back();
    // }
  }

  var names = ["Alejandra Reales", "Pablo Escobar"];
  Widget _renderCharacters() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: names
            .map((name) => CharacterItem(
                  name: name,
                ))
            .toList(),
      );

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
            child: Form(
              // key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Crea tu nueva historia!',
                    style: primaryFont.copyWith(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    label: 'Nombre de la historia:',
                    field: 'name',
                    // validator: clubNameValidator,
                    onChanged: (_, __) {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    label: 'Sinopsis',
                    field: 'sinop',
                    // validator: notEmptyValidator,
                    onChanged: (_, __) {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Personajes:",
                    style: primaryFont.copyWith(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  _renderCharacters(),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color(0xFF9BDBFF),
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.add),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  CustomTextField(
                    label: 'Lugar principal:',
                    field: 'place',
                    // validator: notEmptyValidator,
                    onChanged: (_, __) {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    label: 'Historia completa:',
                    field: 'place',
                    // validator: notEmptyValidator,
                    onChanged: (_, __) {},
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
