part of 'auth_bloc_bloc.dart';

abstract class AuthBlocState extends Equatable {
  const AuthBlocState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class AuthLoaded extends AuthBlocState {
  final bool status;

  const AuthLoaded({required this.status});

  @override
  List<Object> get props => [status];
}

class AuthError extends AuthBlocState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

// Password Reset for Email
class EmailPasswordResetInitial extends AuthBlocState {}

class EmailPasswordResetLoading extends AuthBlocState {}

class EmailPasswordResetLoaded extends AuthBlocState {
  final bool status;
  final String message;

  const EmailPasswordResetLoaded({required this.status, required this.message});

  @override
  List<Object> get props => [status, message];
}

// Password Change
class ChangePasswordInitial extends AuthBlocState {}

class ChangePasswordLoading extends AuthBlocState {}

class ChangePasswordLoaded extends AuthBlocState {
  final bool status;
  final String message;

  const ChangePasswordLoaded({required this.status, required this.message});

  @override
  List<Object> get props => [status, message];
}

class AuthenticationNotAuthenticated extends AuthBlocState {}

class AuthenticationAuthenticated extends AuthBlocState {}

class RegistrationLoadingState extends AuthBlocState {
  final UserModel user;
  const RegistrationLoadingState({required this.user});
  @override
  List<Object> get props => [];
}
