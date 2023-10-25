import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weather_forecast_app/feature/auth/cubits/auth_cubit.dart';
import 'package:weather_forecast_app/feature/auth/models/user_model.dart';
import 'package:weather_forecast_app/utils/navigator_key.dart';

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

  Future<UserModel?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Once signed in, return the UserCredential
      if (user.user != null) {
        return UserModel(
          id: user.user!.uid,
          email: user.user!.email,
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> verifyOTPCode(String otp, String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return UserModel(
          id: userCredential.user?.uid,
          email: userCredential.user?.email,
          phone: userCredential.user?.phoneNumber);
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

  Future<void> phoneRegister(String phone) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: "+62${phone.trim()}",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        log("VERIFICATION ID : $verificationId");
        verificationId = verificationId;
        NavigatorKey.navigatorKey.currentContext!
            .read<AuthCubit>()
            .phoneVerificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
