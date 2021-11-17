import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/controllers/data_controller.dart';
import 'package:world_builder/controllers/followings_controller.dart';
import 'package:world_builder/controllers/user_search_controller.dart';
import 'package:world_builder/ui/utils.dart';
import 'package:world_builder/ui/widgets/custom_button.dart';
import 'package:world_builder/ui/widgets/custom_text_field.dart';
import 'package:world_builder/ui/widgets/user_search_item.dart';

import '../constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _authController = Get.find<AuthController>();
  final _userSearchController = Get.find<UserSearchController>();
  final _followingsController = Get.find<FollowingsController>();

  final _formKey = GlobalKey<FormState>();
  String _searchText = '';

  void _onSearchQChanged(_, text) => setState(() {
        _searchText = text;
      });

  void _onSearchBtnClick() async {
    if (_formKey.currentState!.validate()) {
      Get.focusScope!.unfocus();
      final status = _authController.currentStatus.value as AuthOkStatus;
      await _followingsController.ensureLoaded();
      await _userSearchController.reload(params: {
        'query': _searchText,
      });
    }
  }

  Widget _renderSearchResults() => Obx(() {
        switch (_userSearchController.loadStatus.value) {
          case DataLoadStatus.loading:
          case DataLoadStatus.loaded:
            final status = _authController.currentStatus.value as AuthOkStatus;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _userSearchController.data.value
                  .where((user) => user.uid != status.userData.uid)
                  .map(
                    (user) => UserSearchItem(
                      user: user,
                      followed: _followingsController.data.value
                          .containsKey(user.uid),
                    ),
                  )
                  .toList(),
            );
          case DataLoadStatus.unloaded:
            return const SizedBox();
          case DataLoadStatus.loadedWError:
            return Text(
              'Error al cargar los resultados',
              style: primaryFont.copyWith(fontSize: 20),
            );
        }
      });

  Widget _renderActionButton() => Obx(() {
        if (_userSearchController.loadStatus.value == DataLoadStatus.loading) {
          return CustomButton(
            text: 'BUSCANDO...',
            onClick: _onSearchBtnClick,
            solid: true,
            disabled: true,
          );
        } else {
          return CustomButton(
            text: 'BUSCAR',
            onClick: _onSearchBtnClick,
            solid: true,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buscar usuario',
                  style: primaryFont.copyWith(fontSize: 25),
                ),
                const SizedBox(height: 5),
                Form(
                  key: _formKey,
                  child: CustomTextField(
                    validator: usernameSearchValidator,
                    onChanged: _onSearchQChanged,
                  ),
                ),
                _renderActionButton(),
                const SizedBox(height: 15),
                _renderSearchResults(),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
