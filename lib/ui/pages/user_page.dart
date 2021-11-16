import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/models/user_data.dart';
import 'package:world_builder/ui/widgets/custom_text_field.dart';

import '../constants.dart';

class UserPage extends StatelessWidget {
  final ExternalUserData user;

  const UserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  void _onGoBackClick() => Get.back();

  void _onFollowClick() {}

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
                    IconButton(
                      tooltip: 'Seguir',
                      onPressed: _onFollowClick,
                      icon: const Icon(Icons.person_add),
                      color: defaultBorderColor,
                    ),
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
                // const SizedBox(height: 20),
                // CustomTextField(
                //   initialValue: user.interests,
                //   field: 'interests',
                //   label: 'Intereses',
                //   onChanged: (_, __) {},
                //   type: TextInputType.multiline,
                // ),
                // const SizedBox(height: 10),
                // CustomTextField(
                //   initialValue: user.writerOf,
                //   field: 'writerOf',
                //   label: 'Tipo de literatura que escribo',
                //   onChanged: (_, __) {},
                //   type: TextInputType.multiline,
                // ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
