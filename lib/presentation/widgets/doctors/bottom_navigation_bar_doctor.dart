import 'package:autism/presentation/screens/doctors/BottomNavigationBarDoctor/requests_screen.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

import 'package:autism/presentation/screens/parents/BottomNavigationBarParent/chats_screen.dart';
import 'package:autism/presentation/screens/parents/BottomNavigationBarParent/tips_screen.dart';
import 'package:autism/presentation/screens/parents/BottomNavigationBarParent/settings_screen.dart';
import 'package:autism/logic/services/colors_app.dart';

class MainBottomNavDoctor extends StatefulWidget {
  const MainBottomNavDoctor({super.key});

  @override
  State<MainBottomNavDoctor> createState() => _MainBottomNavDoctorState();
}

class _MainBottomNavDoctorState extends State<MainBottomNavDoctor>
    with TickerProviderStateMixin {
  int _selectedIndex = 1;

  final List<Widget> _pages = const [
    TipsScreen(),
    RequestsScreen(),
    ChatsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Requests",
        labels: const ["Tips", "Requests", "Chats", "Settings"],
        icons: const [
          Icons.lightbulb_outline,
          Icons.list_alt,
          Icons.chat,
          Icons.settings_outlined,
        ],
        tabIconColor: Colors.grey,
        tabIconSelectedColor: Colors.white,
        tabSelectedColor: ColorsApp().primaryColor,
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        onTabItemSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
