import 'package:chat_x/screens/event_page.dart';
import 'package:chat_x/screens/group_page.dart';
import 'package:chat_x/screens/home_page.dart';
import 'package:chat_x/screens/profile_page.dart';
import 'package:chat_x/screens/updated_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int page = 0;
  Color primary = Colors.blueAccent;
  Color secondary = Colors.grey;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        activeColor: primary,
        inactiveColor: secondary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: page == 0 ? primary : secondary,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
                color: page == 1 ? primary : secondary,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.event,
                color: page == 2 ? primary : secondary,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: page == 3 ? primary : secondary,
              ),
              label: ""),
        ],
        onTap: tabChangeListener,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: pageChanges,
        children: const [
          HomePage(),
          GroupPage(),
          EventPage(),
          ProfilePageV2()
        ],
      ),
    );
  }

  void tabChangeListener(int page) {
    pageController.jumpToPage(page);
  }

  void pageChanges(int index) {
    setState(() {
      page = index;
    });
  }

}
