import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/controllers/followings_controller.dart';
import 'package:world_builder/models/user_data.dart';
import 'package:world_builder/ui/constants.dart';
import 'package:world_builder/ui/pages/user_page.dart';

class ClubItem extends StatelessWidget {
  final String club;

  ClubItem({
    Key? key,
    required this.club,
  }) : super(key: key);

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
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                club,
                style: primaryFont.copyWith(fontSize: 22),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Genero",
                    style: primaryFont.copyWith(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.groups,
                        color: defaultBorderColor,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "69",
                        style: primaryFont.copyWith(fontSize: 15),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
