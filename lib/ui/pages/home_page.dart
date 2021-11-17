import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:world_builder/controllers/auth_controller.dart';
import 'package:world_builder/controllers/clubs_controller.dart';
import 'package:world_builder/controllers/followers_controller.dart';
import 'package:world_builder/controllers/followings_controller.dart';
import 'package:world_builder/controllers/user_search_controller.dart';
import 'package:world_builder/ui/constants.dart';
import 'package:world_builder/ui/pages/clubs_page.dart';
import 'package:world_builder/ui/pages/profile_page.dart';
import 'package:world_builder/ui/pages/search_page.dart';
import 'package:world_builder/ui/pages/stories_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authController = Get.find<AuthController>();
  int _selectedIndex = 0;

  _HomePageState() {
    final status = _authController.currentStatus.value as AuthOkStatus;
    Get.find<UserSearchController>()
        .resetData(params: {'user': status.userData});
    Get.find<FollowingsController>()
        .resetData(params: {'uid': status.userData.uid});
    Get.find<FollowersController>()
        .resetData(params: {'uid': status.userData.uid});
    Get.find<ClubsController>().resetData(params: {'uid': status.userData.uid});
  }

  static const List<Widget> _widgetOptions = <Widget>[
    StoriesPage(),
    ClubsPage(),
    SearchPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history_edu),
            label: 'Historias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Clubes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        selectedLabelStyle: primaryFont.copyWith(fontSize: 14),
        unselectedLabelStyle: primaryFont.copyWith(fontSize: 14),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: defaultBorderColor,
        unselectedItemColor: defaultBorderColor.withOpacity(.8),
        backgroundColor: const Color(0xFFE1F4FF),
      ),
    );
  }
}
