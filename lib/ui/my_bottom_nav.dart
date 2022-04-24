import 'package:flutter/material.dart';
import 'package:healthy_san/ui/forum/forum_screen.dart';
import 'package:healthy_san/ui/home/home_screen.dart';
import 'package:healthy_san/ui/profile/profile_screen.dart';
import 'package:healthy_san/utils/base_color.dart';

class MyBottomNav extends StatefulWidget {
  @override
  _MyBottomNavState createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int currentIndex = 0;
  List<Widget> children = [
    HomeScreen(),
    ForumScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: BaseColor.base,
        onTap: (val){
          setState(() {
            currentIndex = val;
          });
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
