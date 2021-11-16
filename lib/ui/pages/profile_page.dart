import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/services/users_service.dart';
import 'package:world_builder/ui/constants.dart';
import 'package:world_builder/ui/pages/login_page.dart';
import 'package:world_builder/ui/widgets/custom_button.dart';
import 'package:world_builder/ui/widgets/custom_text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _authController = Get.find<AuthController>();
  final _usersService = Get.find<UsersService>();
  final Map<String, String> _data = {
    'fullName': '',
    'taste': '',
    'interests': '',
    'writerOf': '',
  };

  _ProfilePageState() {
    final status = _authController.currentStatus.value as AuthOkStatus;
    final user = status.userData;
    _data['fullName'] = user.fullName;
    _data['taste'] = user.taste;
    _data['interests'] = user.interests;
    _data['writerOf'] = user.writerOf;
  }

  void _onFieldChanged(String field, String value) => setState(() {
        _data[field] = value;
      });

  void _onLogoutBtnClick() async {
    Get.focusScope!.unfocus();
    await _authController.logout();
    Get.off(() => const LoginPage());
  }

  void _onSaveBtnClick() async {
    Get.focusScope!.unfocus();
    final updateOk = await _authController.updateCurrentUserData(
      _data['fullName']!,
      _data['taste']!,
      _data['interests']!,
      _data['writerOf']!,
    );
    if (updateOk) {
      Get.snackbar('Correcto', 'Datos actualizados exitosamente');
    } else {
      Get.snackbar('Error', 'Ha ocurrido un problema al actualizar los datos');
    }
  }

  Widget _renderUsernameLabel() => Obx(() {
        final status = _authController.currentStatus.value;
        if (status is AuthOkStatus) {
          return Text(
            "@${status.userData.username}",
            style: primaryFont.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          return Text(
            'Cerrando sesión...',
            style: primaryFont.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
        }
      });

  Widget _renderActionButton() => Obx(() {
        final status = _authController.currentStatus.value;
        if (status is AuthCurrentUserUpdateStatus) {
          return CustomButton(
            text: 'GUARDANDO...',
            onClick: _onSaveBtnClick,
            disabled: true,
            solid: true,
            fullWidth: true,
          );
        } else {
          return CustomButton(
            text: 'GUARDAR',
            onClick: _onSaveBtnClick,
            solid: true,
            fullWidth: true,
          );
        }
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Mi cuenta',
                      style: primaryFont.copyWith(fontSize: 30),
                    ),
                    IconButton(
                      tooltip: 'Cerrar sesión',
                      onPressed: _onLogoutBtnClick,
                      icon: const Icon(Icons.logout),
                      color: defaultBorderColor,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    'https://cdni.rt.com/actualidad/public_images/2021.04/article/6069eac8e9ff71083922df47.jpg',
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                _renderUsernameLabel(),
                const SizedBox(height: 30),
                CustomTextField(
                  initialValue: _data['fullName']!,
                  field: 'fullName',
                  label: 'Nombre',
                  onChanged: _onFieldChanged,
                  type: TextInputType.name,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  initialValue: _data['taste']!,
                  field: 'taste',
                  label: 'Gustos literarios',
                  onChanged: _onFieldChanged,
                  type: TextInputType.multiline,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  initialValue: _data['interests']!,
                  field: 'interests',
                  label: 'Intereses',
                  onChanged: _onFieldChanged,
                  type: TextInputType.multiline,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  initialValue: _data['writerOf']!,
                  field: 'writerOf',
                  label: 'Tipo de literatura que escribo',
                  onChanged: _onFieldChanged,
                  type: TextInputType.multiline,
                ),
                const SizedBox(height: 40),
                _renderActionButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
