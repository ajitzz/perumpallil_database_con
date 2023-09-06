// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'package:perumpallil_augg/screens/home_screen.dart';

import 'package:perumpallil_augg/screens/loan/loan.dart';
// import 'package:perumpallil_augg/screens/nav/tab_index_provider.dart';
import 'package:perumpallil_augg/screens/profile_screen.dart';
import 'package:perumpallil_augg/common/color_extension.dart';
import 'package:perumpallil_augg/screens/register.dart';

class MyBottomNavigation extends StatefulWidget {
  static const String id = 'navigationHome';
  const MyBottomNavigation({super.key});

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  int selectTab = 0;
  PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentTabView = const HomeScreen();
  List<Widget> screens = [
    const HomeScreen(),
    LoanScreen(),

    const ProfileScreen(), // Corrected the class name to ProfileScreen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.gray,
      body: Stack(
        children: [
          PageStorage(bucket: pageStorageBucket, child: currentTabView),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset("assets/images/bottom_bar_bg.png"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 0;
                                    currentTabView = const HomeScreen();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/images/home.png",
                                  width: 20,
                                  height: 20,
                                  color: selectTab == 0
                                      ? TColor.white
                                      : TColor.gray30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 1;
                                    currentTabView = LoanScreen();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/images/budgets.png",
                                  width: 20,
                                  height: 20,
                                  color: selectTab == 1
                                      ? TColor.white
                                      : TColor.gray30,
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                                height: 50,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 2;
                                    currentTabView = const MyRegister();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/images/calendar.png",
                                  width: 20,
                                  height: 20,
                                  color: selectTab == 2
                                      ? TColor.white
                                      : TColor.gray30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectTab = 3;
                                    currentTabView = const ProfileScreen();
                                  });
                                },
                                icon: Image.asset(
                                  "assets/images/creditcards.png",
                                  width: 20,
                                  height: 20,
                                  color: selectTab == 3
                                      ? TColor.white
                                      : TColor.gray30,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectTab = 4;
                            currentTabView = LoanScreen();
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: TColor.secondary.withOpacity(0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Image.asset(
                            "assets/images/center_btn.png",
                            width: 55,
                            height: 55,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
