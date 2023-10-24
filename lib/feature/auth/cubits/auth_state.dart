part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserModel userData;

  const AuthSuccess({required this.userData});

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
