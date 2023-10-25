part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthWithPhone extends AuthState {
  final String verificationId;

  const AuthWithPhone({required this.verificationId});

  @override
  // TODO: implement props
  List<Object> get props => [verificationId];
}

final class AuthSuccess extends AuthState {
  final UserModel userData;
  final String type;

  const AuthSuccess({required this.userData, this.type = ""});

  @override
  // TODO: implement props
  List<Object> get props => [userData];
}

final class AuthFailed extends AuthState {
  final String message;

  const AuthFailed({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
