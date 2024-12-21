import 'package:ecommerce/src/domain/usecases/account_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/profile_model.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountUsecase accountUsecase;
  AccountBloc(this.accountUsecase) : super(AccountInitial()) {
    on<AccountEvent>((event, emit) async {
      if (event is GetAccountEvent) {
        emit(GetAccountLoading());
        var failurOrSuccess = await accountUsecase.getAccount();
        failurOrSuccess.fold(
          (fail) => emit(GetAccountError(msg: fail.toString())),
          (success) => emit(
            GetAccountSuccess(profileModel: success),
          ),
        );
      }
      if (event is UpdateAccountEvent) {
        emit(UpdateAccountLoading());
        var failurOrSuccess =
            await accountUsecase.updateAccount(event.userModel, event.ppImage);
        failurOrSuccess.fold(
          (fail) => emit(UpdateAccountError(msg: fail.toString())),
          (success) => emit(
            UpdateAccountSuccess(),
          ),
        );
      }
      if (event is UpdateDeviceToken) {
        emit(UpdateDeviceTokenLoading());
        var failureOrSuccess = await accountUsecase.updateDeviceToken(
            deviceToken: event.deviceToken);
        failureOrSuccess.fold((fail) => emit(UpdateAccountError(msg: fail)),
            (success) => emit(UpdateAccountSuccess()));
      }
    });
  }
}
