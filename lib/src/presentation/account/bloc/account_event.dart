part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetAccountEvent extends AccountEvent {}

class UpdateAccountEvent extends AccountEvent {
  final Map<String,String>  userModel;
  final String?  ppImage;

  const UpdateAccountEvent({required this.userModel,required this.ppImage});
}
class UpdateDeviceToken extends AccountEvent{
  final String deviceToken;

  const UpdateDeviceToken({required this.deviceToken});
}
