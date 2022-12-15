import "package:flutter/material.dart";
import '../utility/color.dart';

import '../utility/icons.dart';
import 'bankdetail/bankview.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 3;
  static const List<Widget> _pages = <Widget>[
    Tab(icon: Icon(randomIcon.home)),
    Tab(
        icon: Icon(
      randomIcon.transactions,
      color: Colors.black,
    )),
    Tab(icon: Icon(randomIcon.menu)),
    BankDetail(),
    Tab(icon: Icon(randomIcon.user)),
  ];

  void _touch(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: logogreen,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 0,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(randomIcon.home), label: "Home"),
            const BottomNavigationBarItem(
                icon: Icon(randomIcon.transactions), label: "xd"),
            BottomNavigationBarItem(
                icon: Container(
                    decoration: const BoxDecoration(
                      color: navigationColor,
                      shape: BoxShape.circle,
                    ),
                    height: 56,
                    width: 56,
                    child: const Icon(
                      randomIcon.menu,
                      color: Colors.white,
                    )),
                label: "Home"),
            const BottomNavigationBarItem(
                icon: Icon(randomIcon.card), label: "dd"),
            const BottomNavigationBarItem(
                icon: Icon(randomIcon.user), label: "dd")
          ],
          currentIndex: _selectedIndex,
          onTap: _touch),
    );
  }
}
