import 'package:flutter/material.dart';
import 'package:world_builder/models/club.dart';
import 'package:world_builder/ui/constants.dart';

class ClubItem extends StatelessWidget {
  final Club club;

  const ClubItem({
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
                club.name,
                style: primaryFont.copyWith(fontSize: 22),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    club.gender,
                    style: primaryFont.copyWith(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.groups,
                        color: defaultBorderColor,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        club.members.toString(),
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
