import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/controllers/followings_controller.dart';
import 'package:world_builder/models/user_data.dart';
import 'package:world_builder/ui/constants.dart';
import 'package:world_builder/ui/pages/user_page.dart';

class UserSearchItem extends StatelessWidget {
  final _authController = Get.find<AuthController>();
  final _followingsController = Get.find<FollowingsController>();
  final ExternalUserData user;
  final bool followed;

  UserSearchItem({
    Key? key,
    required this.user,
    required this.followed,
  }) : super(key: key);

  void _onItemClick() => Get.to(() => UserPage(user: user));

  void _onStopFollowingClick() async {
    await _followingsController.stopFollowing(user.uid);
    await _followingsController.reload();
    Get.snackbar('Correcto', "Has dejado de seguir a @${user.username}");
  }

  void _onStartFollowingClick() async {
    await _followingsController.startFollowing(user.uid);
    await _followingsController.reload();
    Get.snackbar('Correcto', "Ahora eres seguidor de @${user.username}");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
              IconButton(
                onPressed:
                    followed ? _onStopFollowingClick : _onStartFollowingClick,
                icon: Icon(followed ? Icons.person_remove : Icons.person_add),
                color: defaultBorderColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
