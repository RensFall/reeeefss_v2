import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/view/screen/home/homepage.dart';
import 'package:reefs_nav/view/screen/home/pages/profile/update_profile.dart';
import 'package:reefs_nav/view/widget/navigation/nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  static const String profile = 'ProfileScreen';

  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user == null) {
      // Handle case when user is not logged in
      return Scaffold(
        body: Center(
          child: Text('44'.tr),
        ),
      );
    }

    String currentUserId = user.uid;

    return Scaffold(
      endDrawer: NavBar(),
      // floatingActionButton: const DrawerTrigger(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      appBar: AppBar(
        title: Text('28'.tr),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Add map icon
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const HomeNavPage(),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Center(
              child: Text('43'.tr),
            );
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          String userName = userData['userName'];
          String email = userData['email'];

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/icon.jpg"),
                ),
                Text(
                  '2'.tr,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold),
                ),
                Text(
                  userName,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  email,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => UpdateUserProfile(userId: user.uid),
                    ));
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                    color: Colors.black,
                  ),
                  label: Text('27'.tr,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    backgroundColor: Colors.purple,
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 10),

                //Bar Chart
                Container(
                  width:
                      330, // Adjust the width and height to your desired size
                  height: 230,
                  decoration: BoxDecoration(
                    color: Colors
                        .white, // Customize the color as per your preference
                    borderRadius:
                        BorderRadius.circular(10), // Set the border radius here
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '99'.tr,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('reports')
                                .where('userId', isEqualTo: user.uid)
                                .snapshots(),
                            builder: (context, reportsSnapshot) {
                              if (reportsSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!reportsSnapshot.hasData ||
                                  reportsSnapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: Text('100'.tr),
                                );
                              }

                              return ListView(
                                children:
                                    reportsSnapshot.data!.docs.map((reportDoc) {
                                  var reportData =
                                      reportDoc.data() as Map<String, dynamic>;
                                  String reportTitle =
                                      reportData['reportTitle'];
                                  String reportDescription =
                                      reportData['reportDescription'];
                                  // You can extract other fields as necessary

                                  return ListTile(
                                    title: Text(reportTitle),
                                    subtitle: Text(reportDescription),
                                    // Display additional information as needed
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
