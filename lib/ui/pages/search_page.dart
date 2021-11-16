import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/controllers/core_data_controller.dart';
import 'package:world_builder/services/users_service.dart';
import 'package:world_builder/ui/utils.dart';
import 'package:world_builder/ui/widgets/custom_button.dart';
import 'package:world_builder/ui/widgets/custom_text_field.dart';

import '../constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _authController = Get.find<AuthController>();
  final _searchController = Get.find<SearchController>();

  final _formKey = GlobalKey<FormState>();
  String _searchText = '';

  void _onSearchQChanged(_, text) => setState(() {
        _searchText = text;
      });

  void _onSearchBtnClick() async {
    if (_formKey.currentState!.validate()) {
      Get.focusScope!.unfocus();
      final status = _authController.currentStatus.value;
      if (status is AuthOkStatus) {
        await _searchController.searchOver(_searchText, status.userData.region);
      } else {
        Get.snackbar('Error', 'Ha sucedido un error, inicie sesión nuevamente');
      }
    }
  }

  Widget _renderSearchResults() => Obx(() {
        switch (_searchController.loadStatus.value) {
          case CoreDataLoadStatus.loading:
          case CoreDataLoadStatus.loaded:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _searchController.data.value
                  .map((e) => Text(e.username))
                  .toList(),
            );
          case CoreDataLoadStatus.unloaded:
            return const SizedBox();
          case CoreDataLoadStatus.loadedWError:
            return Text(
              'Error al cargar los resultados',
              style: primaryFont.copyWith(fontSize: 20),
            );
        }
      });

  Widget _renderActionButton() => Obx(() {
        if (_searchController.loadStatus.value == CoreDataLoadStatus.loading) {
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
                  style: primaryFont.copyWith(fontSize: 30),
                ),
                Form(
                  key: _formKey,
                  child: CustomTextField(
                    validator: usernameSearchValidator,
                    onChanged: _onSearchQChanged,
                  ),
                ),
                _renderActionButton(),
                _renderSearchResults(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
