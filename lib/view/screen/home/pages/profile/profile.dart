import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/view/widget/navigation/NavBar.dart';
import 'package:reefs_nav/view/screen/home/pages/profile/update_profile.dart';

class ProfileScreen extends StatelessWidget {
  static const String profile = 'ProfileScreen';

  const ProfileScreen({super.key});

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
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      appBar: AppBar(
        title: Text('28'.tr),
      ),
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
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage("assets/images/icon.jpg"),
                ),
                Text(
                  '2'.tr,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => UpdateUserProfile(userId: user.uid),
                    ));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  label: Text('27'.tr,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    backgroundColor: Colors.purple,
                    textStyle: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w700),
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
