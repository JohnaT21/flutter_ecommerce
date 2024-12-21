import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/presentation/auth/blocs/auth/auth_bloc_bloc.dart';
import 'package:ecommerce/src/presentation/auth/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:ecommerce/src/presentation/auth/blocs/phone_auth/phone_auth_event.dart';
import 'package:ecommerce/src/presentation/auth/blocs/phone_auth/phone_auth_state.dart';
import 'package:ecommerce/src/presentation/auth/pages/register_page.dart';
import 'package:ecommerce/src/presentation/shared_widgets/app_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../core/helpers/localization_helper.dart';
import '../../account/bloc/account_bloc.dart';
import '../../bottom_navigator/pages/bottom_navigator_page.dart';

class OTPVerificationPage extends StatefulWidget {
  static const routeName = "/otp_verification";
  const OTPVerificationPage({super.key});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  TextEditingController textEditingController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();

  String otpValue = "";
  String _comingSms = 'Unknown';
  Future<void> initSmsListener() async {
    String? comingSms;
    try {
      comingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      _comingSms = comingSms!;

      otpValue = _comingSms[0] +
          _comingSms[1] +
          _comingSms[2] +
          _comingSms[3] +
          _comingSms[4] +
          _comingSms[5];
      otpController.setValue(_comingSms[0], 0);
      otpController.setValue(_comingSms[1], 1);
      otpController.setValue(_comingSms[2], 2);
      otpController.setValue(_comingSms[3], 3);
      otpController.setValue(_comingSms[4], 4);
      otpController.setValue(_comingSms[5], 5);
      //used to set the code in the message to a string and setting it to a textcontroller. .
    });
  }

  @override
  void initState() {
    super.initState();

    initSmsListener();
  }

  @override
  void dispose() {
    // textEditingController.dispose();
    AltSmsAutofill().unregisterListener();
    otpController.clear();
    otpValue = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    return Scaffold(
      backgroundColor: kFadedBackgroundColor,
      appBar: AppBar(
        backgroundColor: kFadedBackgroundColor,
        foregroundColor: kDarkTextColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(getTranslation(context, "Verification")),
      ),
      body: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, authState) {
          if (authState is AuthLoaded && authState.status == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  getTranslation(context, "Successfully registered"),
                ),
              ),
            );
            Navigator.of(context).pushNamed(
              BottomNavigatorPage.routeName,
            );
          }

          // error logging in
          else if (authState is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  authState.message,
                ),
              ),
            );
          }
        },
        builder: (context, authState) =>
            BlocListener<PhoneAuthBloc, PhoneAuthState>(
                listener: (context, state) {
          if (state is PhoneAuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is PhoneAuthVerified) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(getTranslation(context, "Phone verified")),
            ));
            Navigator.pushNamed(context, RegisterPage.routeName,
                arguments: args[1]);

            // UserModel user = sl.get<AuthBloc>().state.props[0] as UserModel;

            // user.phone = args[1];
            // sl.get<AuthBloc>().add(
            //       RegistrationLoadingEvent(
            //         userInfo: user,
            //       ),
            //     );
          }
        }, child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
                    builder: (context, state) {
          if (state is PhoneAuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox(
              width: 1.sw,
              height: 1.sh,
              child: Padding(
                  padding: EdgeInsets.only(top: 72.h, left: 24.w, right: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading Text
                      Text(
                        getTranslation(context, "Insert verification code"),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: kDarkTextColor),
                      ),
                      //
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: Text(
                          getTranslation(
                              context, "we have sent you verification code to"),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 18.sp,
                                  ),
                        ),
                      ),

                      // Editable Phone Number
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Row(
                          children: [
                            // Phone Number
                            Text(
                              "251${args[1]}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 18.sp,
                                    color: kDarkTextColor,
                                    letterSpacing: 0.56,
                                  ),
                            ),

                            // Edit Icon
                            Padding(
                              padding: EdgeInsets.only(left: 6.w),
                              child: Icon(
                                Icons.edit,
                                color: kSecondaryColor,
                                size: 20.h,
                              ),
                            )
                          ],
                        ),
                      ),

                      // OTP Input
                      Padding(
                        padding: EdgeInsets.only(top: 100.h),
                        child: SizedBox(
                          width: 1.sw,
                          height: 70.h,
                          child: OTPTextField(
                              controller: otpController,
                              length: 6,
                              width: MediaQuery.of(context).size.width.w,
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldWidth: 45,
                              fieldStyle: FieldStyle.box,
                              outlineBorderRadius: 15,
                              style: const TextStyle(fontSize: 17),
                              onChanged: (pin) {
                                setState(() {
                                  otpValue = pin;
                                });
                              },
                              onCompleted: (pin) {
                                otpValue = pin;
                              }),
                        ),
                      ),
                      AppButton(
                        onPressed: () async {
                          final accountBloc =
                              BlocProvider.of<AccountBloc>(context);

                          context.read<PhoneAuthBloc>().add(VerifySentOtpEvent(
                              otpCode: otpValue, verificationId: args[0]));

                          final token =
                              await FirebaseMessaging.instance.getToken();
                          accountBloc
                              .add(UpdateDeviceToken(deviceToken: token!));
                        },
                        child: Text(
                          getTranslation(context, "continue text"),
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    color: kBaseColor,
                                  ),
                        ),
                      ),
                    ],
                  )));
        })),
      ),
    );
  }
}
