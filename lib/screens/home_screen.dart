import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: unused_import

import 'package:perumpallil_augg/components/pageview_recipe_list.dart';
// import 'package:perumpallil_augg/components/popular_recipe_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget currentTabView = const PageViewRecipeList();
  // Initialize with the default tab view

  void updateTabView(Widget widget) {
    setState(() {
      currentTabView = widget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe7eefb),
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        toolbarHeight: 0, // Set app bar color
        // title: const Text(
        //   'Loan Details',
        //   style: TextStyle(
        //     fontWeight: FontWeight.bold,
        //     fontSize: 20,
        //     color: Colors.white,
        //   ),
        // ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          primary: true,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.red.shade900,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.5,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PERUMPALLIL',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Text(
                          'FINANCE',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.amber.shade800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 36,
                      child: SvgPicture.asset('assets/svg/icon-nav.svg'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16.53,
            ),
            const PageViewRecipeList(),
            const SizedBox(
              height: 42.52,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
