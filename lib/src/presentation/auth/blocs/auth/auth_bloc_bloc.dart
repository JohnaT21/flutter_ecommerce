import 'package:bloc/bloc.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/config/local_storage.dart';
import 'package:ecommerce/src/data/models/user_model.dart';
import 'package:ecommerce/src/data/models/user_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';

import '../../../../data/models/error_responce.dart';
import '../../../../domain/repositories/auth_repo.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(AuthInitial()) {
    on<AuthBlocEvent>(
      (event, emit) async {
        // Register User
        if (event is AppLoaded) {
          if (TOKEN.isEmpty) {
            emit(AuthenticationNotAuthenticated());
          } else {
            bool hasExpired = JwtDecoder.isExpired(TOKEN);

            if (hasExpired) {
              Storage.removeValue("TOKEN");
              Storage.removeValue("USERID");
              emit(AuthenticationNotAuthenticated());
            } else {
              emit(AuthenticationAuthenticated());
            }
          }
        }
        // if (event is RegisterUser) {
        //   emit(AuthLoading());
        //   final response = await authRepo.register(
        //     userInfo: event.userInfo,
        //   );

        //   response.fold((final error) {
        //     emit(
        //       AuthError(message: error),
        //     );
        //   }, (final result) {
        //     Storage.saveValue("TOKEN", result.data.tokens.access.token);
        //     Storage.saveValue("USERID", result.data.user.id);

        //     TOKEN = Storage.getValue("TOKEN") ?? '';
        //     USERID = Storage.getValue("USERID") ?? '';
        //     emit(
        //       const AuthLoaded(status: true),
        //     );
        //   });
        // }

        if (event is RegistrationLoadingEvent) {
          emit(RegistrationLoadingState(user: event.userInfo));
        }

        // loginst2@
        if (event is LoginUser) {
          emit(AuthLoading());
          final loginResult = await authRepo.login(
              email: event.email, password: event.password);

          // success
          if (loginResult is UserResponse) {
            Storage.saveValue("TOKEN", loginResult.data.tokens.access.token);
            Storage.saveValue("USERID", loginResult.data.user.id);
            TOKEN = Storage.getValue("TOKEN") ?? '';
            USERID = Storage.getValue("USERID") ?? '';
            emit(
              const AuthLoaded(status: true),
            );
            emit(AuthenticationAuthenticated());
          }
          // error
          else {
            Logger().d(loginResult);
            emit(
              AuthError(
                  message: loginResult is ErrorResponce
                      ? loginResult.error.message
                      : loginResult),
            );
          }
        }

        // Password Reset
        if (event is RequestEmailPasswordReset) {
          emit(EmailPasswordResetLoading());

          final response =
              await authRepo.requestEmailPasswordReset(email: event.email);

          if (response == "Reset Email sent") {
            emit(
              const EmailPasswordResetLoaded(
                status: true,
                message: "Reset Email sent",
              ),
            );
          } else {
            emit(
              EmailPasswordResetLoaded(
                status: false,
                message: response,
              ),
            );
          }
        }

        // change password
        if (event is ChangePassword) {
          emit(ChangePasswordLoading());

          final response = await authRepo.changePassword(
            userId: event.userId,
            oldPassword: event.oldPassword,
            newPassword: event.newPassword,
          );

          if (response == "Successfully changed") {
            emit(
              const ChangePasswordLoaded(status: true, message: ""),
            );
          } else {
            emit(
              ChangePasswordLoaded(
                status: false,
                message: response,
              ),
            );
          }
        }

        //google login
        if (event is GoogleSignInEvent) {
          emit(AuthLoading());
          final loginResult = await authRepo.googleSignIn(event.token);
          print("google sign in...");
          print(loginResult);
          // success
          if (loginResult is UserResponse) {
            Storage.saveValue("TOKEN", loginResult.data.tokens.access.token);
            Storage.saveValue("USERID", loginResult.data.user.id);
            TOKEN = Storage.getValue("TOKEN") ?? '';
            USERID = Storage.getValue("USERID") ?? '';
            print(USERID);
            emit(
              const AuthLoaded(status: true),
            );
            emit(AuthenticationAuthenticated());
          }
          // error
          else if (loginResult is ErrorResponce) {
            emit(
              AuthError(message: loginResult.error.message),
            );
          } else {
            emit(
              const AuthError(message: "no connection"),
            );
          }
        }
      },
    );
  }
}
