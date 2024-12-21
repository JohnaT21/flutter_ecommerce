part of 'auth_bloc_bloc.dart';

abstract class AuthBlocEvent extends Equatable {
  const AuthBlocEvent();

  @override
  List<Object> get props => [];
}

class RegistrationLoadingEvent extends AuthBlocEvent {
  final UserModel userInfo;

  const RegistrationLoadingEvent({required this.userInfo});

  @override
  List<Object> get props => [];
}

// class RegisterUser extends AuthBlocEvent {
//   final UserModel userInfo;

//   const RegisterUser({required this.userInfo});

//   @override
//   List<Object> get props => [];
// }

class LoginUser extends AuthBlocEvent {
  final String email;
  final String password;

  const LoginUser({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// Reset Email Password
class RequestEmailPasswordReset extends AuthBlocEvent {
  final String email;

  const RequestEmailPasswordReset({required this.email});

  @override
  List<Object> get props => [email];
}

// password change
class ChangePassword extends AuthBlocEvent {
  final String userId;
  final String oldPassword;
  final String newPassword;

  const ChangePassword({
    required this.userId,
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [userId, oldPassword, newPassword];
}

class AppLoaded extends AuthBlocEvent {}

class GoogleSignInEvent extends AuthBlocEvent {
  final String token;

  const GoogleSignInEvent({required this.token});
  @override
  List<Object> get props => [token];
}
