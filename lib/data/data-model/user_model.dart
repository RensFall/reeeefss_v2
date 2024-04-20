import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String createAt;
  String email;
  String userName;
  String passWord;
  String photoUrl;

  UserModel({
    required this.id,
    required this.createAt,
    required this.email,
    required this.userName,
    required this.passWord,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createAt': createAt,
      'email': email,
      'userName': userName,
      'passWord': passWord,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    return UserModel(
      id: doc.id,
      createAt: data['createAt'],
      email: data["email"],
      userName: data["userName"],
      passWord: data["passWord"],
      photoUrl: data["photoUrl"],
    );
    // String id = '';
    // String createAt = '';
    // String email = '';
    // String userName = '';
    // String passWord = '';
    // String photoUrl = '';

    // try {
    //   id = doc.get('id');
    // } catch (e) {
    //   id = '';
    // }

    // try {
    //   createAt = doc.get('createAt');
    // } catch (e) {
    //   createAt = '';
    // }

    // try {
    //   email = doc.get('email');
    // } catch (e) {
    //   email = '';
    // }

    // try {
    //   userName = doc.get('userName');
    // } catch (e) {
    //   userName = '';
    // }

    // try {
    //   passWord = doc.get('passWord');
    // } catch (e) {
    //   passWord = '';
    // }

    // try {
    //   photoUrl = doc.get('photoUrl');
    // } catch (e) {
    //   photoUrl = '';
    // }
  }
}
