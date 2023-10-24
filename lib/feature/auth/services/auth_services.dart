import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_forecast_app/feature/auth/models/user_model.dart';

class AuthServices {
  Future<UserModel?> checkUserToken() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return UserModel(
          id: user.uid, email: user.email, phone: user.phoneNumber);
    } else {
      return null;
    }
  }

  Future<UserModel?> emailRegistration(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user?.uid != null) {
        return UserModel(
            id: credential.user?.uid,
            email: credential.user?.email,
            phone: credential.user?.phoneNumber);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> emailPasswordLogIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user?.uid != null) {
        return UserModel(
            id: credential.user?.uid,
            email: credential.user?.email,
            phone: credential.user?.phoneNumber);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
