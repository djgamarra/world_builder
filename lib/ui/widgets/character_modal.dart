import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/models/character.dart';

import '../utils.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class CharacterModal extends StatefulWidget {
  final Function(Character) onCharacterSaved;

  const CharacterModal({
    Key? key,
    required this.onCharacterSaved,
  }) : super(key: key);

  @override
  State<CharacterModal> createState() => _CharacterModalState();
}

class _CharacterModalState extends State<CharacterModal> {
  final _formKey = GlobalKey<FormState>();
  String name = '', role = '';

  void _onCharacterSaveBtnClick() async {
    if (_formKey.currentState!.validate()) {
      widget.onCharacterSaved(Character(name: name, role: role));
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            onChanged: (_, text) {
              setState(() {
                name = text;
              });
            },
            label: 'Nombre del personaje',
            validator: clubNameValidator,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            onChanged: (_, text) {
              setState(() {
                role = text;
              });
            },
            label: 'Rol',
            validator: clubNameValidator,
          ),
          const SizedBox(height: 10),
          CustomButton(
            text: 'GUARDAR',
            onClick: _onCharacterSaveBtnClick,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}
