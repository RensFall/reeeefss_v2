import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/view/widget/auth/customebuttonauth.dart';
import 'package:reefs_nav/view/widget/auth/custometextformauth.dart';

class UpdateForm extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  final String user;

  const UpdateForm({
    Key? key,
    required this.username,
    required this.email,
    required this.password,
    required this.user,
  }) : super(key: key);

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    // Set the initial values of text controllers
    nameController.text = widget.username;
    emailController.text = widget.email;
    passwordController.text = widget.password;

    super.initState();
  }

  Future<void> updateUser() async {
    var collection = FirebaseFirestore.instance.collection('users');
    await collection.doc(widget.user).update({
      'userName': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage("assets/images/icon.jpg"),
        ),
        const SizedBox(height: 30),
        CustomeTextFormAuth(
          hinttext: "46".tr,
          labeltext: "45".tr,
          iconData: Icons.person_2_outlined,
          mycontroller: nameController,
        ),
        CustomeTextFormAuth(
          hinttext: "9".tr,
          labeltext: "8".tr,
          iconData: Icons.email_outlined,
          mycontroller: emailController,
        ),
        CustomeButtonAuth(
          //save button
          text: '47'.tr,
          onPressed: () async {
            await updateUser();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
