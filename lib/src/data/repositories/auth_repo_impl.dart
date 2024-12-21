import 'package:dartz/dartz.dart';
import 'package:ecommerce/src/data/models/user_model.dart';
import 'package:ecommerce/src/data/models/user_response_model.dart' as UR;
import 'package:ecommerce/src/domain/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/network/network_info.dart';
import '../data_sources/auth_data_source.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthDataSource authDataSource;
  final NetworkInfo networkInfo;
  final FirebaseAuth _firebaseAuth;

  AuthRepoImpl(this.authDataSource, this.networkInfo, this._firebaseAuth);

  @override
  Future login({required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      return authDataSource.login(email: email, password: password);
    } else {
      return "Please check your connection!";
    }
  }

  // register new user
  @override
  Future<Either<String, UR.UserResponse>> register(
      {required UserModel userInfo}) async {
    if (await networkInfo.isConnected) {
      var res = await authDataSource.register(userInfo: userInfo);
      return Right(res);
    } else {
      return const Left("Please check your connection!");
    }
  }

  // reset password
  @override
  Future<String> requestEmailPasswordReset({required String email}) async {
    if (await networkInfo.isConnected) {
      return authDataSource.requestEmailPasswordReset(email: email);
    } else {
      return "Please check your connection!";
    }
  }

  @override
  Future<String> changePassword(
      {required String userId,
      required String oldPassword,
      required String newPassword}) async {
    if (await networkInfo.isConnected) {
      return authDataSource.changePassword(
          userId: userId, oldPassword: oldPassword, newPassword: newPassword);
    } else {
      return "Please check your connection!";
    }
  }

  @override
  Future<User> getUser() async {
    var user = _firebaseAuth.currentUser;
    return user!;
  }

  @override
  Future<void> sendOtp(
      String phoneNumber,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }

  @override
  Future<UserCredential> verifyAndLogin(
      String verifictionId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verifictionId, smsCode: smsCode);

    return _firebaseAuth.signInWithCredential(authCredential);
  }

  @override
  Future<dynamic> googleSignIn(String token) async {
    if (await networkInfo.isConnected) {
      return authDataSource.googleSignIn(token);
    } else {
      return "Please check your connection!";
    }
  }
}
