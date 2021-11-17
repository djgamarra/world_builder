import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/controllers/clubs_controller.dart';
import 'package:world_builder/ui/utils.dart';
import 'package:world_builder/ui/widgets/custom_text_field.dart';

import '../constants.dart';

class CreateClub extends StatefulWidget {
  const CreateClub({Key? key}) : super(key: key);

  @override
  State<CreateClub> createState() => _CreateClubState();
}

class _CreateClubState extends State<CreateClub> {
  final _clubsController = Get.find<ClubsController>();
  final _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final _data = <String, String>{
    'name': '',
    'gender': '',
    'description': '',
  };

  void _onFieldChanged(String field, String value) => setState(() {
        _data[field] = value;
      });

  void _onSaveBtnClick() async {
    if (_formKey.currentState!.validate()) {
      Get.focusScope!.unfocus();
      final status = _authController.currentStatus.value as AuthOkStatus;
      await _clubsController.createClub(
        uid: status.userData.uid,
        name: _data['name']!,
        gender: _data['gender']!,
        description: _data['description']!,
      );
      _clubsController.reload();
      Get.back();
    }
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
            child: Form(
              key: _formKey,
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
                  CustomTextField(
                    label: 'Nombre del club',
                    field: 'name',
                    validator: clubNameValidator,
                    onChanged: _onFieldChanged,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    label: 'Género',
                    field: 'gender',
                    validator: notEmptyValidator,
                    onChanged: _onFieldChanged,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    label: 'Descripción',
                    field: 'description',
                    validator: notEmptyValidator,
                    type: TextInputType.multiline,
                    onChanged: _onFieldChanged,
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
