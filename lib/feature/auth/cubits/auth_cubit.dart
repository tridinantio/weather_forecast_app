import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_forecast_app/feature/auth/models/user_model.dart';
import 'package:weather_forecast_app/feature/auth/services/auth_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  UserModel? user;

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

  Future<void> logIn(String email, String password) async {
    emit(AuthLoading());
    UserModel? user = await AuthServices().emailPasswordLogIn(email, password);
    user != null
        ? {user = user, emit(AuthSuccess(userData: user))}
        : emit(const AuthFailed(message: "auth failed"));
  }
}
