import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/view/screen/auth/login.dart';
import 'package:reefs_nav/view/screen/home/pages/reportPage.dart';

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
      //backgroundColor: const Color(0xFF242527),
      child: ListView(
        children: [
          ListTile(
            title: const Text("Reefs"),
            leading: const Icon(
              Icons.info_rounded,
            ),
            onTap: () {
              setState(() {
                _isItemExpanded = !_isItemExpanded;
              });
            },
          ),

          if (_isItemExpanded)
            ExpansionTile(
              title: const Text("Geomorphic"),
              children: [
                ListTile(
                  title: const Text("Inner Reef Flat"),
                  leading: Container(
                    width: 20,
                    height: 20,
                    color: Color(0xFFc5a7cb),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Outer Reef Flat"),
                  leading: Container(
                    width: 20,
                    height: 20,
                    color: const Color(0xFF92739d),
                  ),
                  onTap: () {
                    // Handle tapping
                  },
                ),
                ListTile(
                  title: const Text("Reef Crest"),
                  leading: Container(
                    width: 20,
                    height: 20,
                    color: const Color(0xFF614272),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Shallow Lagoon"),
                  leading: Container(
                    width: 20,
                    height: 20,
                    color: const Color(0xFF77d0fc),
                  ),
                  onTap: () {},
                ),
                ListTile(
                    title: const Text("Sheltered Reef Slope"),
                    leading: Container(
                      width: 20,
                      height: 20,
                      color: const Color(0xFF10bda6),
                    ),
                    onTap: () {}),
                ListTile(
                  title: const Text("Terrestrial Reef Flat"),
                  leading: Container(
                    width: 20,
                    height: 20,
                    color: const Color(0xFFfbdefb),
                  ),
                  onTap: () {},
                ),

                // Add more ListTile widgets as needed
              ],
            ),
          if (_isItemExpanded)
            ExpansionTile(
              title: const Text("Reef Extent"),
              children: [
                ListTile(
                  title: const Text("Reef Extent"),
                  leading: Container(
                    width: 20,
                    height: 20,
                    color: const Color(0xFF980b46),
                  ),
                  onTap: () {},
                ),
              ],
            ),

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
                  onTap: () {
                    //Get.offAll(ReportScreen());
                    showDialog(
                      context: context,
                      builder: (context) => ReportScreen(),
                    );
                  },
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
