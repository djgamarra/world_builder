import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/controllers/followers_controller.dart';
import 'package:world_builder/controllers/followings_controller.dart';
import 'package:world_builder/models/user_data.dart';

import '../constants.dart';

class UserPage extends StatelessWidget {
  final _followingsController = Get.find<FollowingsController>();
  final _userFollowingsController = FollowingsController();
  final _userFollowersController = FollowersController();
  final ExternalUserData user;

  UserPage({
    Key? key,
    required this.user,
  }) : super(key: key) {
    _userFollowingsController.ensureLoaded(params: {'uid': user.uid});
    _userFollowersController.ensureLoaded(params: {'uid': user.uid});
  }

  void _onGoBackClick() => Get.back();

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

  Widget _renderFollowIcon() => Obx(() {
        final followed = _followingsController.data.value.containsKey(user.uid);
        return IconButton(
          onPressed: followed ? _onStopFollowingClick : _onStartFollowingClick,
          icon: Icon(followed ? Icons.person_remove : Icons.person_add),
          color: defaultBorderColor,
        );
      });

  Widget _renderFollowsBox() => Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Siguiendo',
                    style: primaryFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    _userFollowingsController.loadStatus.value ==
                            DataLoadStatus.loading
                        ? '...'
                        : "${_userFollowingsController.data.value.length}",
                    style: primaryFont,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Seguidores',
                    style: primaryFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    _userFollowersController.loadStatus.value ==
                            DataLoadStatus.loading
                        ? '...'
                        : "${_userFollowersController.data.value.length}",
                    style: primaryFont,
                  ),
                ],
              ),
            ),
          ),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Atrás',
                      onPressed: _onGoBackClick,
                      icon: const Icon(Icons.arrow_back),
                      color: defaultBorderColor,
                    ),
                    Text(
                      "@${user.username}",
                      style: primaryFont.copyWith(fontSize: 25),
                    ),
                    _renderFollowIcon(),
                  ],
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      'https://cdni.rt.com/actualidad/public_images/2021.04/article/6069eac8e9ff71083922df47.jpg',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _renderFollowsBox(),
                const SizedBox(height: 30),
                Text(
                  'Gustos literarios',
                  textAlign: TextAlign.start,
                  style: primaryFont.copyWith(
                    fontSize: 18,
                    color: defaultBorderColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  user.taste,
                  textAlign: TextAlign.start,
                  style: primaryFont.copyWith(
                    fontSize: 17,
                    color: defaultBorderColor,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Intereses',
                  textAlign: TextAlign.start,
                  style: primaryFont.copyWith(
                    fontSize: 18,
                    color: defaultBorderColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  user.interests,
                  textAlign: TextAlign.start,
                  style: primaryFont.copyWith(
                    fontSize: 17,
                    color: defaultBorderColor,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Tipo de literatura que escribo',
                  textAlign: TextAlign.start,
                  style: primaryFont.copyWith(
                    fontSize: 18,
                    color: defaultBorderColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  user.writerOf,
                  textAlign: TextAlign.start,
                  style: primaryFont.copyWith(
                    fontSize: 17,
                    color: defaultBorderColor,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
