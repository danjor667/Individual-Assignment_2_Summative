import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mylinafoot/pages/live/direct.dart';
import 'package:mylinafoot/pages/programme/programme.dart';
import 'package:mylinafoot/utils/loader.dart';
import 'AccueilPage.dart';
import 'DirectPage.dart';

class BottomNavigationBarPage extends StatefulWidget {
  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  RxInt currentIndex = 0.obs;

  final List<Widget> _pages = [
    AccueilPage(),
    DirectPage(), // Example additional page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: currentIndex.value,
        children: _pages,
      )),
      bottomNavigationBar: Obx(
            () => Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(0xFFFF5050),
          ),
          child: BottomNavigationBar(
            onTap: (e) {
              currentIndex.value = e;
            },
            currentIndex: currentIndex.value,
            unselectedItemColor: Loader.UnSelectedbackgroundColorBottomNavBar,
            selectedItemColor: Loader.SelectedbackgroundColorBottomNavBar,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: "Accueil"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.live_tv_rounded), label: "Direct"), // New item
            ],
          ),
        ),
      ),
    );
  }
}
