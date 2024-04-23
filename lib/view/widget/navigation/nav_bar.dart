import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/view/screen/auth/login.dart';
import 'package:reefs_nav/core/services/tileManager/map_cache_manger.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isLanguageExpanded = false;
  bool _isCacheExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: const Color(0xFF242527),
      child: ListView(
        children: [
          ListTile(
            title: const Text('Settings'),
            leading: const Icon(Icons.settings),
            onTap: () {
              setState(() {
                _isLanguageExpanded = !_isLanguageExpanded;
              });
            },
          ),
          if (_isLanguageExpanded)
            ExpansionTile(
              title: const Text('Language'),
              leading: const Icon(Icons.language),
              children: [
                ListTile(
                  title: const Text('Arabic'),
                  onTap: () {
                    // Implement language change to Arabic
                    Get.updateLocale(const Locale('Arabic', ''));
                  },
                ),
                ListTile(
                  title: const Text('English'),
                  onTap: () {
                    // Implement language change to English
                    Get.updateLocale(const Locale('English', ''));
                  },
                ),
              ],
            ),
          ListTile(
            title: Text('Cache Memory'),
            leading: const Icon(Icons.memory),
            onTap: () {
              setState(() {
                _isCacheExpanded = !_isCacheExpanded;
              });
            },
          ),
          if (_isCacheExpanded)
            ExpansionTile(
              title: Text('Cache Memory'),
              children: [
                ListTile(
                  title: const Text("Clear Map Cache"),
                  leading: const Icon(Icons.delete),
                  onTap: () async {
                    await ImageCacheManager().emptyCache();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF262626),
                        content: const Text("Map cache cleared successflly."),
                        duration: const Duration(milliseconds: 1500),
                        width: 350,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
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
