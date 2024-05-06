// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reefs_nav/core/Exception_handler/exception_handler.dart';
import 'package:reefs_nav/core/constant/enum.dart';
import 'package:reefs_nav/data/data-model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  String errorCode = '';

  Future<User?> signIn(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        Get.snackbar('77'.tr, '126'.tr, snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('77'.tr, '125'.tr, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<User?> signUp(
    String email,
    String password,
    String userName,
    String fuel,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      if (user != null) {
        // Send email verification
        await user.sendEmailVerification();

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
            'fuel': fuel,
          });
          Get.snackbar('111'.tr, '112'.tr, snackPosition: SnackPosition.BOTTOM);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('91'.tr);
        // errorCode = '91'.tr;
        Get.snackbar('77'.tr, '91'.tr, snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        print('92'.tr);
        // errorCode = '92'.tr;
        Get.snackbar('77'.tr, '92'.tr, snackPosition: SnackPosition.BOTTOM);
      }
    }
    return user;
  }

//To Check if email is exists or not
  Future<bool> checkIfEmailExists(String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      // Query Firestore to check if any document has the given email
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: email).get();
      // If the querySnapshot is not empty, it means the email exists
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // If an error occurs during the query, print the error and return false
      print('Error checking email existence: $e');
      return false;
    }
  }

//To Send ResetPassword to user
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

//To display User Details in User profile
  Future<UserModel> getUserDetails(String email, String userName) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final snapshot = await db.collection('users').get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapShot(e)).single;
    return userData;
  }

//To Retrieves the fuel consumption rate associated with the currently logged-in user.
  Future<double?> getFuel() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await db.collection('users').doc(user.uid).get();

      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        dynamic fuelData = userData['fuel'];

        if (fuelData is double) {
          // If 'fuel' field is already a double, return it directly
          return fuelData;
        } else if (fuelData is String) {
          // If 'fuel' field is a String, parse it to double
          try {
            return double.parse(fuelData);
          } catch (e) {
            errorCode = 'Error parsing fuel data: $e';
            return null;
          }
        } else {
          errorCode = 'Unknown data type for fuel field: $fuelData';
          return null;
        }
      } else {
        return null; // Handle case when user document doesn't exist
      }
    } else {
      return null; // Handle case when user is not logged in
    }
  }

  static Future<void> setLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }
}
