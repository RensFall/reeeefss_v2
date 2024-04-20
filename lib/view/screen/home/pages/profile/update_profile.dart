import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/controller/editprofilecontroller.dart';

class UpdateUserProfile extends StatefulWidget {
  const UpdateUserProfile({super.key, required this.userId});
  final String userId;

  @override
  State<UpdateUserProfile> createState() => UpdateUserProfileState();
}

class UpdateUserProfileState extends State<UpdateUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('28'.tr, style: Theme.of(context).textTheme.headlineMedium),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              var output = snapshot.data!.data();
              if (output == null) {
                // Handle case when data is null
                return Text('43'.tr);
              }

              var nameValue = output['userName'] ?? ''; // Handle null value
              var emailValue = output['email'] ?? ''; // Handle null value
              var passValue = output['passWord'] ?? ''; // Handle null value

              return Padding(
                padding: const EdgeInsets.all(25),
                child: UpdateForm(
                  username: nameValue,
                  email: emailValue,
                  password: passValue,
                  user: widget.userId,
                ),
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
