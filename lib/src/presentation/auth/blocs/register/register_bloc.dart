import 'package:bloc/bloc.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/config/local_storage.dart';
import 'package:ecommerce/src/data/models/user_model.dart';
import 'package:ecommerce/src/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepo authRepo;
  RegisterBloc(this.authRepo) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterUser) {
        emit(RegisterLoading());
        final response = await authRepo.register(
          userInfo: event.userInfo,
        );

        response.fold((final error) {
          emit(
            RegisterError(message: error),
          );
        }, (final result) {
          Storage.saveValue("TOKEN", result.data.tokens.access.token);
          Storage.saveValue("USERID", result.data.user.id);
          emit(
            const RegisterLoaded(),
          );
        });
      }
    });
  }
}
