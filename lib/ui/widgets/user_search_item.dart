import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/models/user_data.dart';
import 'package:world_builder/ui/constants.dart';
import 'package:world_builder/ui/pages/user_page.dart';

class UserSearchItem extends StatelessWidget {
  final _authController = Get.find<AuthController>();
  final ExternalUserData user;

  UserSearchItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  void _onItemClick() => Get.to(() => UserPage(user: user));

  Widget _renderActionButton() {
    final status = _authController.currentStatus.value as AuthOkStatus;
    if (user.uid == status.userData.uid) {
      return const SizedBox();
    } else {
      return IconButton(
        onPressed: () {},
        icon: const Icon(Icons.person_add),
        color: defaultBorderColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: _onItemClick,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 4, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "@${user.username}",
                style: primaryFont.copyWith(fontSize: 17),
              ),
              _renderActionButton(),
            ],
          ),
        ),
      ),
    );
  }
}
