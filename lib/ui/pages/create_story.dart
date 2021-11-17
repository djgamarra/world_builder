import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/controllers/stories_controller.dart';
import 'package:world_builder/models/character.dart';
import 'package:world_builder/ui/widgets/character_item.dart';
import 'package:world_builder/ui/widgets/character_modal.dart';
import 'package:world_builder/ui/widgets/custom_text_field.dart';

import '../constants.dart';
import '../utils.dart';

class CreateStory extends StatefulWidget {
  const CreateStory({Key? key}) : super(key: key);

  @override
  State<CreateStory> createState() => _CreateStoryState();
}

class _CreateStoryState extends State<CreateStory> {
  final _storiesController = Get.find<StoriesController>();
  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final _data = <String, dynamic>{
    'name': '',
    'gender': '',
    'synopsis': '',
    'place': '',
    'completeStory': '',
  };
  final _characters = <Character>[];

  void _onFieldChanged(String field, String value) => setState(() {
        _data[field] = value;
      });

  void _onCharacterSaved(Character character) => setState(() {
        _characters.add(character);
      });

  void _onCharacterDeleted(Character character) => setState(() {
        _characters.remove(character);
      });

  void _onCharacterAddBtnClick() => Get.defaultDialog(
        title: 'Invitar a club',
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        titlePadding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        titleStyle: primaryFont.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        content: CharacterModal(onCharacterSaved: _onCharacterSaved),
      );

  void _onSaveBtnClick() async {
    if (_formKey.currentState!.validate()) {
      Get.focusScope!.unfocus();
      final status = _authController.currentStatus.value as AuthOkStatus;
      await _storiesController.createStory(
        status.userData.uid,
        _data['name']!,
        _data['gender']!,
        _data['synopsis']!,
        _data['place']!,
        _data['completeStory']!,
        _characters,
      );
      _storiesController.reload();
      Get.back();
    }
  }

  Widget _renderCharacters() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _characters
            .map((character) => CharacterItem(
                  character: character,
                  onCharacterDelete: _onCharacterDeleted,
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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Crea tu nueva historia!',
                    style: primaryFont.copyWith(fontSize: 25),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    label: 'Nombre de la historia',
                    field: 'name',
                    validator: storyNameValidator,
                    onChanged: _onFieldChanged,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Género',
                    field: 'gender',
                    validator: notEmptyValidator,
                    onChanged: _onFieldChanged,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Sinopsis',
                    field: 'synopsis',
                    validator: notEmptyValidator,
                    onChanged: _onFieldChanged,
                    type: TextInputType.multiline,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Personajes",
                    style: primaryFont.copyWith(fontSize: 17),
                  ),
                  const SizedBox(height: 5),
                  _renderCharacters(),
                  const SizedBox(height: 5),
                  Align(
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color(0xFF9BDBFF),
                      child: IconButton(
                        color: defaultBorderColor,
                        icon: const Icon(Icons.add),
                        onPressed: _onCharacterAddBtnClick,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Lugar principal',
                    field: 'place',
                    validator: notEmptyValidator,
                    onChanged: _onFieldChanged,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Historia completa',
                    field: 'completeStory',
                    validator: notEmptyValidator,
                    onChanged: _onFieldChanged,
                    type: TextInputType.multiline,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
