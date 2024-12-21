part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final UserModel userInfo;

  const RegisterUser({required this.userInfo});

  @override
  List<Object> get props => [];
}
