import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

import 'package:autism/presentation/screens/parents/BottomNavigationBar/chats_screen.dart';
import 'package:autism/presentation/screens/parents/BottomNavigationBar/doctors_screen.dart';
import 'package:autism/presentation/screens/parents/BottomNavigationBar/games_screen.dart';
import 'package:autism/presentation/screens/parents/BottomNavigationBar/tips_screen.dart';
import 'package:autism/presentation/screens/parents/BottomNavigationBar/settings_screen.dart';
import 'package:autism/logic/services/colors_app.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({super.key});

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav>
    with TickerProviderStateMixin {
  int _selectedIndex = 1;

  final List<Widget> _pages = const [
    TipsScreen(),
    DoctorsScreen(),
    ChatsScreen(),
    GamesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: "Doctors",
        labels: const ["Tips", "Doctors", "Chats", "Games", "Settings"],
        icons: const [
          Icons.lightbulb_outline,
          Icons.local_hospital_outlined,
          Icons.chat_bubble_outline,
          Icons.videogame_asset_outlined,
          Icons.settings_outlined,
        ],
        tabIconColor: Colors.grey,
        tabIconSelectedColor: Colors.white,
        tabSelectedColor: ColorsApp().primaryColor,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTabItemSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
