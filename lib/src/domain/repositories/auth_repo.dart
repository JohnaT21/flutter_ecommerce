import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/data/models/user_model.dart';
import 'package:ecommerce/src/data/models/user_response_model.dart' as UR;
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<dynamic> login({required String email, required String password});
  Future<Either<String, UR.UserResponse>> register(
      {required UserModel userInfo});

  Future<String> requestEmailPasswordReset({required String email});

  Future<String> changePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  });

  Future<void> sendOtp(
      String phoneNumber,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout);

  Future<UserCredential> verifyAndLogin(String verifictionId, String smsCode);
  Future<User> getUser();
  Future<dynamic> googleSignIn(String token);
}
