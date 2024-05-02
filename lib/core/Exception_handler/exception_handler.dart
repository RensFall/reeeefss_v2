import 'package:firebase_auth/firebase_auth.dart';
import 'package:reefs_nav/core/constant/enum.dart';

class AuthExceptionHandler {
  static handlerAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }
}
