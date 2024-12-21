part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

///fetch account
class GetAccountLoading extends AccountState {}

class GetAccountSuccess extends AccountState {
  final ProfileModel profileModel;

  const GetAccountSuccess({required this.profileModel});
}

class GetAccountError extends AccountState {
  final String msg;

  const GetAccountError({required this.msg});
}

///Update account
class UpdateAccountLoading extends AccountState {}

class UpdateAccountSuccess extends AccountState {}

class UpdateAccountError extends AccountState {
  final String msg;

  const UpdateAccountError({required this.msg});
}

/// Update device token

class UpdateDeviceTokenLoading extends AccountState {}

class UpdateDeviceTokenSuccess extends AccountState {}

class UpdateDeviceTokenError extends AccountState {
  final String msg;

  const UpdateDeviceTokenError({required this.msg});
}
