import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:perumpallil_augg/screens/loan/loan.dart'; // Import your HomeScreen

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.pushNamed(context, LoanScreen.id); // Navigate to HomeScreen
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: _selectedIndex == 0
              ? SvgPicture.asset(
                  'assets/svg/icon-home-selected.svg',
                )
              : SvgPicture.asset(
                  'assets/svg/icon-home.svg',
                ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 1
              ? SvgPicture.asset(
                  'assets/svg/icon-search-selected.svg',
                )
              : SvgPicture.asset(
                  'assets/svg/icon-search.svg',
                ),
          label: 'Payment',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 2
              ? SvgPicture.asset(
                  'assets/svg/icon-notification-selected.svg',
                )
              : SvgPicture.asset(
                  'assets/svg/icon-notification.svg',
                ),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: _selectedIndex == 3
              ? SvgPicture.asset(
                  'assets/svg/icon-settings-selected.svg',
                )
              : SvgPicture.asset(
                  'assets/svg/icon-settings.svg',
                ),
          label: 'Settings',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.red.shade900,
      onTap: _onItemTapped,
      backgroundColor: Colors.transparent,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    );
  }
}
