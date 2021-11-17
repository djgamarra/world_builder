import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/clubs_controller.dart';
import 'package:world_builder/controllers/invitations_controller.dart';
import 'package:world_builder/models/invitation.dart';

import '../constants.dart';

class InvitationItem extends StatelessWidget {
  final _invitationsController = Get.find<InvitationsController>();
  final _clubsController = Get.find<ClubsController>();
  final Invitation invitation;

  InvitationItem({
    Key? key,
    required this.invitation,
  }) : super(key: key);

  void _onAcceptInvitationBtnClick() async {
    await _invitationsController.acceptInvitation(invitation);
    Get.snackbar(
        'Correcto', "Ahora perteneces al club ${invitation.club!.name}");
    await reload();
  }

  void _onDeclineInvitationBtnClick() async {
    await _invitationsController.declineInvitation(invitation);
    Get.snackbar('Correcto', 'Has rechazado la invitación');
    await reload();
  }

  Future<void> reload() => Future.wait([
        _clubsController.reload(),
        _invitationsController.reload(),
      ]);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invitation.club!.name,
                  style: primaryFont.copyWith(fontSize: 15),
                ),
                Text(
                  invitation.club!.gender,
                  style: primaryFont.copyWith(fontSize: 12),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'Aceptar',
                  onPressed: _onAcceptInvitationBtnClick,
                  color: Colors.green,
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.done),
                ),
                IconButton(
                  tooltip: 'Rechazar',
                  onPressed: _onDeclineInvitationBtnClick,
                  color: Colors.red,
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
