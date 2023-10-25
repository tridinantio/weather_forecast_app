import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_forecast_app/feature/auth/models/user_model.dart';
import 'package:weather_forecast_app/feature/auth/services/auth_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  UserModel? user;
  String phoneVerificationId = "";

  Future<void> checkUserToken() async {
    emit(AuthLoading());
    UserModel? user = await AuthServices().checkUserToken();
    user != null
        ? {
            log(user.email.toString()),
            user = user,
            emit(AuthSuccess(userData: user))
          }
        : emit(const AuthFailed(message: "auth failed"));
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    UserModel? user = await AuthServices().emailRegistration(email, password);
    user != null
        ? {user = user, emit(AuthSuccess(userData: user))}
        : emit(const AuthFailed(message: "auth failed"));
  }

  Future<void> registerWithPhone(String phone) async {
    emit(AuthLoading());
    await AuthServices()
        .phoneRegister(phone)
        .then((value) => log("PHONEVERID IN CUBIT : $phoneVerificationId"));

    emit(AuthWithPhone(verificationId: phoneVerificationId));
  }

  Future<void> verifyOtp(String otp) async {
    try {
      emit(AuthLoading());
      UserModel? user =
          await AuthServices().verifyOTPCode(otp, phoneVerificationId);

      emit(AuthSuccess(userData: user!));
    } catch (e) {
      emit(AuthFailed(message: e.toString()));
    }
  }

  Future<void> logInWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    UserModel? user = await AuthServices().emailPasswordLogIn(email, password);
    user != null
        ? {user = user, emit(AuthSuccess(userData: user))}
        : emit(const AuthFailed(message: "auth failed"));
  }

  Future<void> logInWithGoogle() async {
    emit(AuthLoading());
    UserModel? user = await AuthServices().signInWithGoogle();
    user != null
        ? {user = user, emit(AuthSuccess(userData: user))}
        : emit(const AuthFailed(message: "auth failed"));
  }
}
