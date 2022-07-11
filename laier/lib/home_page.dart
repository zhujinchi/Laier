import 'package:flutter/material.dart';
import 'package:laier/pages/history/history_screen.dart';
import 'package:laier/pages/measure/measure_screen.dart';
import 'package:laier/pages/profile/profile_screen.dart';

import 'animated_bottom_bar.dart';
import 'data/system_info.dart';
import 'data/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;

  final _inactiveColor = Colors.grey;

  //Color backgroundColor = const Color(0xff050B18);
  Color backgroundColor = const Color(0xffffffff);

  List<Widget> pages = [];

  List<String> titles = ['历史', '测量', '我的'];

  @override
  void initState() {
    super.initState();

    pages
      ..add(const HistoryScreen())
      ..add(const MeasureScreen())
      ..add(const ProfileScreen());
    _init();
  }

  Future<void> _init() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: IndexedStack(
          index: _currentIndex,
          children: pages,
        ),
        bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return AnimatedBottomBar(
      containerHeight: 56,
      backgroundColor: backgroundColor,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 12,
      curve: Curves.easeInOut,
      onItemSelected: (index) {
        setState(() => _currentIndex = index);
      },
      items: <MyBottomNavigationBarItem>[
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.history),
          iconUnselected: const Icon(
            Icons.history,
            color: Colors.black54,
          ),
          title: Text(titles[0]),
          activeColor: SystemInfo.shared().themeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.calculate),
          iconUnselected: const Icon(
            Icons.calculate,
            color: Colors.black54,
          ),
          title: Text(titles[1]),
          activeColor: SystemInfo.shared().themeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        MyBottomNavigationBarItem(
          icon: const Icon(Icons.person),
          iconUnselected: const Icon(
            Icons.person,
            color: Colors.black54,
          ),
          title: Text(titles[2]),
          activeColor: SystemInfo.shared().themeColor,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
