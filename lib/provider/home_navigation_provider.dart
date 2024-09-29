import 'package:assignment/presentation/course_page.dart';
import 'package:assignment/presentation/home_page.dart';
import 'package:assignment/presentation/message_page.dart';
import 'package:assignment/presentation/profile_page.dart';
import 'package:assignment/presentation/search_page.dart';
import 'package:flutter/material.dart';

class HomeNavigationProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List<Widget> pageList = [
    const HomePage(),
    const CoursePage(),
    const SearchPage(),
    const MessagePage(),
    const ProfilePage(),
  ];

  void changeBottomNavbarItem(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
