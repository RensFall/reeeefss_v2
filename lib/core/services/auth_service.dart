// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reefs_nav/core/Exception_handler/exception_handler.dart';
import 'package:reefs_nav/core/constant/enum.dart';
import 'package:reefs_nav/data/data-model/user_model.dart';

class AuthService extends ChangeNotifier {
  Future<User?> signIn(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for this email');
      } else {
        print('wrong password');
      }
    }
    return user;
  }

//aggawffwssddzz
  Future<User?> signUp(
    String email,
    String password,
    String userName,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      if (user != null) {
        final QuerySnapshot result = await firebaseFirestore
            .collection('users')
            .where(
              'id',
              isEqualTo: user.uid,
            )
            .get();
        final List<DocumentSnapshot> documents = result.docs;

        if (documents.isEmpty) {
          firebaseFirestore.collection('users').doc(user.uid).set({
            'userName': userName,
            'photoUrl': user.photoURL,
            'id': user.uid,
            'password': password,
            'createAte': DateTime.now().millisecondsSinceEpoch.toString(),
            'email': email,
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for this email');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<AuthStatus> forgotPassword(String email) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    AuthStatus _status = AuthStatus.unknown;
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
          (e) => _status = AuthExceptionHandler.handlerAuthException(e),
        );
    return _status;
  }

  Future<UserModel> getUserDetails(String email, String userName) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final snapshot = await db.collection('users').get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapShot(e)).single;
    return userData;
  }
}
