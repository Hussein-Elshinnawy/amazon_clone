import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/variables.dart';
import 'package:badges/badges.dart' as badges;

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages=[
    const HomeScreen(),
    const Center(child: Text('cart page')),
    const AccountScreen(),
  ];

  void updatePage(int page){
    setState(() {
      _page=page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen= context.watch<UserProvider>().user.cart.length;// short syntax for user provider
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Variables.selectedNavBarColor,
        unselectedItemColor: Variables.unselectedNavBarColor,
        backgroundColor: Variables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 0
                          ? Variables.selectedNavBarColor
                          : Variables.backgroundColor,
                      width: bottomBarBorderWidth),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 1
                          ? Variables.selectedNavBarColor
                          : Variables.backgroundColor,
                      width: bottomBarBorderWidth),
                ),
              ),
              child: badges.Badge(
                  badgeContent: Text(userCartLen.toString()),
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.white, elevation: 0),
                  child: const Icon(Icons.shopping_cart_outlined)),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 2
                          ? Variables.selectedNavBarColor
                          : Variables.backgroundColor,
                      width: bottomBarBorderWidth),
                ),
              ),
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
