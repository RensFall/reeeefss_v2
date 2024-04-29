import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/view/screen/home/pages/info.dart';
import 'package:reefs_nav/view/screen/home/pages/profile/profile.dart';
import 'package:reefs_nav/view/screen/home/pages/report_page.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'pages/map.dart';

class HomeNavPage extends StatefulWidget {
  const HomeNavPage({Key? key}) : super(key: key);

  @override
  _HomeNavPageState createState() => _HomeNavPageState();
}

class _HomeNavPageState extends State<HomeNavPage> {
  final _controller = PageController();
  int _currentPageIndex = 0; // Track the visibility of the button

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _controller,
            children: const <Widget>[
              MapPage(),
              ProfileScreen(),
            ],
            onPageChanged: (index) {
              // Update the visibility of the button based on the current page
              setState(() {
                _currentPageIndex = index; // Hide button on page 1
              });
            },
          ),
          Positioned(
            top: 30,
            left: 340,
            child: Visibility(
              visible: _currentPageIndex != 1 &&
                  _currentPageIndex != 2, // Show or hide the button
              child: Container(
                width: 40,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  color: Color(0xFF262626),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.info),
                      color: Colors.white,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Info();
                          },
                        );
                      },
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    IconButton(
                      icon: Icon(Icons.not_listed_location_outlined),
                      color: Colors.white,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ReportPage();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        controller: _controller,
        flat: true,
        useActiveColorByDefault: false,
        color: const Color(0xFF262626), // the color of the bar
        items: [
          RollingBottomBarItem(Icons.map,
              label: '102'.tr, activeColor: Colors.white),
          RollingBottomBarItem(Icons.person,
              label: '101'.tr, activeColor: Colors.white),
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
