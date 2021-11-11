import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:world_builder/controllers/users_controller.dart';
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
  final _usersController = Get.find<UsersController>();
  final Map<String, String> _data = {
    'fullName': '',
    'taste': '',
    'interests': '',
    'writerOf': '',
  };

  _ProfilePageState() {
    _usersController.currentStatus.listen((status) {
      if (status == AuthStatus.loggedOut) {
        Get.off(() => const LoginPage());
      }
    });
    _usersController.errorMessage.listen((errorMessage) {
      if (errorMessage != null) {
        Get.snackbar('Error', errorMessage);
      }
    });
    final currentUser = _usersController.currentUser.value!;
    _data['fullName'] = currentUser.fullName;
    _data['taste'] = currentUser.taste;
    _data['interests'] = currentUser.interests;
    _data['writerOf'] = currentUser.writerOf;
  }

  void _onFieldChanged(String field, String value) => setState(() {
        _data[field] = value;
      });

  void _onLogoutBtnClick() {
    Get.focusScope!.unfocus();
    _usersController.logout();
  }

  void _onSaveBtnClick() {
    Get.focusScope!.unfocus();
    _usersController.updateProfile(
      _data['fullName']!,
      _data['taste']!,
      _data['interests']!,
      _data['writerOf']!,
    );
    Get.snackbar('Correcto', 'Datos actualizados');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

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
                Text(
                  "@${_usersController.currentUser.value!.username}",
                  style: primaryFont.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  initialValue: _data['fullName']!,
                  field: 'fullName',
                  label: 'Nombre real',
                  onChanged: _onFieldChanged,
                  type: TextInputType.name,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  initialValue: _data['taste']!,
                  field: 'taste',
                  label: 'Gustos literarios',
                  onChanged: _onFieldChanged,
                  type: TextInputType.name,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  initialValue: _data['interests']!,
                  field: 'interests',
                  label: 'Intereses',
                  onChanged: _onFieldChanged,
                  type: TextInputType.name,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  initialValue: _data['writerOf']!,
                  field: 'writerOf',
                  label: 'Tipo de literatura que escribo',
                  onChanged: _onFieldChanged,
                  type: TextInputType.name,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'GUARDAR',
                  onClick: _onSaveBtnClick,
                  disabled: _usersController.loading.value,
                  solid: true,
                  fullWidth: true,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
