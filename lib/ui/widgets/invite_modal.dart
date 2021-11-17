import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/invitations_controller.dart';
import 'package:world_builder/models/club.dart';

import '../utils.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class InviteModal extends StatefulWidget {
  final Club club;

  const InviteModal({
    Key? key,
    required this.club,
  }) : super(key: key);

  @override
  State<InviteModal> createState() => _InviteModalState();
}

class _InviteModalState extends State<InviteModal> {
  final _invitationsController = Get.find<InvitationsController>();
  final _formKey = GlobalKey<FormState>();
  String username = '';
  bool loading = false;

  void _onSendInvitationBtnClick(String username) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      await _invitationsController.sendInvitation(username, widget.club.id);
      setState(() {
        loading = true;
      });
      Get.back();
      Get.snackbar('Correcto', 'Invitación enviada');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          key: _formKey,
          child: CustomTextField(
            onChanged: (_, text) {
              setState(() {
                username = text;
              });
            },
            label: 'Nombre de usuario',
            validator: usernameValidator,
          ),
        ),
        const SizedBox(height: 10),
        CustomButton(
          text: loading ? 'ENVIANDO...' : 'ENVIAR INVITACIÓN',
          onClick: () => _onSendInvitationBtnClick(username),
          fullWidth: true,
          disabled: loading,
        ),
      ],
    );
  }
}
