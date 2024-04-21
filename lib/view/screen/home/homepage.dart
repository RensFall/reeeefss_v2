import 'package:flutter/material.dart';
import 'package:reefs_nav/view/screen/home/pages/profile/profile.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'pages/addPage.dart';
import 'pages/map.dart';
import 'package:reefs_nav/view/widget/navigation/NavBar.dart';

class HomeNavPage extends StatefulWidget {
  const HomeNavPage({Key? key}) : super(key: key);
  @override
  _HomeNavPageState createState() => _HomeNavPageState();
}

class _HomeNavPageState extends State<HomeNavPage> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavBar(),
      floatingActionButton: const DrawerTrigger(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: PageView(
        controller: _controller,
        children: const <Widget>[
          MapPage(),
          addPointPage(),
          ProfileScreen(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        controller: _controller,
        flat: true,
        useActiveColorByDefault: false,
        color: const Color(0xFF262626), // the color of the bar
        items: const [
          RollingBottomBarItem(Icons.map,
              label: 'home', activeColor: Colors.white),
          RollingBottomBarItem(Icons.add,
              label: 'add', activeColor: Colors.white),
          RollingBottomBarItem(Icons.person,
              label: 'profile', activeColor: Colors.white),
        ],
        enableIconRotation: true,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(microseconds: 300),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}
