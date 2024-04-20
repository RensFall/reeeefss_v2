import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/view/screen/auth/login.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isItemExpanded = false;
  bool _isSettingsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          const Divider(),
          ListTile(
            title: const Text('Settings'),
            leading: const Icon(Icons.settings),
            onTap: () {
              setState(() {
                _isSettingsExpanded = !_isSettingsExpanded;
              });
            },
          ),
          if (_isSettingsExpanded)
            ExpansionTile(
              title: const Text('Language'),
              leading: const Icon(Icons.language),
              children: [
                ListTile(
                  title: const Text('Arabic'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('English'),
                  onTap: () {},
                ),
              ],
            ),
          if (_isSettingsExpanded)
            ExpansionTile(
              title: Text('Cache Memory'),
              children: [
                ListTile(
                  title: const Text("Clear Map Cache"),
                  leading: const Icon(Icons.delete),
                  onTap: () {},
                ),
              ],
            ),
          if (_isSettingsExpanded)
            ExpansionTile(
              title: const Text('Help'),
              leading: const Icon(Icons.help),
              children: [
                ListTile(
                  title: const Text("Report Feedback"),
                  onTap: () {},
                )
              ],
            ),
          const Divider(),
          Align(
            alignment: Alignment.bottomRight,
            child: ListTile(
              title: const Text("Log Out"),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                Get.offAll(const Login());
              },
            ),
          ),

          // Icon(Icons.logout),
        ],
      ),
    );
  }
}

class DrawerTrigger extends StatelessWidget {
  const DrawerTrigger({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
        size: 30,
      ),
      highlightColor: const Color(0xFF262626),
      onPressed: () {
        Scaffold.of(context).openEndDrawer();
      },
    );
  }
}
