import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/view/screen/auth/login.dart';
import 'package:reefs_nav/core/services/tileManager/map_cache_manger.dart';

import '../../../core/localization/changelocalization.dart';

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
      child: ListView(
        children: [
          ListTile(
            title: Text('57'.tr),
            leading: const Icon(Icons.settings),
            onTap: () {
              setState(() {
                _isLanguageExpanded = !_isLanguageExpanded;
              });
            },
          ),
          if (_isLanguageExpanded)
            ExpansionTile(
              title: Text('75'.tr),
              leading: const Icon(Icons.language),
              children: [
                ListTile(
                  title: Text('81'.tr),
                  onTap: () {
                    Get.find<LocalController>()
                        .changeLang('Arabic'); // Change language to Arabic
                  },
                ),
                ListTile(
                  title: Text('82'.tr),
                  onTap: () {
                    Get.find<LocalController>()
                        .changeLang('English'); // Change language to english
                  },
                ),
              ],
            ),
          ListTile(
            title: Text('83'.tr),
            leading: const Icon(Icons.memory),
            onTap: () {
              setState(() {
                _isCacheExpanded = !_isCacheExpanded;
              });
            },
          ),
          if (_isCacheExpanded)
            ExpansionTile(
              title: Text('83'.tr),
              children: [
                ListTile(
                  title: Text("84".tr),
                  leading: const Icon(Icons.delete),
                  onTap: () async {
                    await ImageCacheManager().emptyCache();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xFF262626),
                        content: Text("85".tr),
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
              title: Text("26".tr),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                Get.offAll(const Login());
              },
            ),
          ),
        ],
      ),
    );
  }
}
