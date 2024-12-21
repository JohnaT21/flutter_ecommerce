import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/presentation/auth/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:ecommerce/src/presentation/auth/blocs/phone_auth/phone_auth_event.dart';
import 'package:ecommerce/src/presentation/auth/blocs/phone_auth/phone_auth_state.dart';
import 'package:ecommerce/src/presentation/auth/pages/otp_page.dart';
import 'package:ecommerce/src/presentation/shared_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../core/helpers/localization_helper.dart';

class PhoneLoginPage extends StatefulWidget {
  static const String routeName = "/phone_login_page";
  const PhoneLoginPage({Key? key}) : super(key: key);

  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  void _sendOtp({required String phoneNumber, required BuildContext context}) {
    final phoneNumberWithCode = "+251$phoneNumber";
    //print(phoneNumberWithCode);
    context.read<PhoneAuthBloc>().add(
          SendOtpToPhoneEvent(
            phoneNumber: phoneNumberWithCode,
          ),
        );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<PhoneAuthBloc, PhoneAuthState>(
      listener: (context, state) {
        if (state is PhoneAuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        } else if (state is PhoneAuthCodeSentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(getTranslation(context, "Otp sent")),
          ));
          Navigator.pushNamed(context, OTPVerificationPage.routeName,
              arguments: [state.verificationId, _phoneController.text]);
        }
      },
      child:
          BlocBuilder<PhoneAuthBloc, PhoneAuthState>(builder: (context, state) {
        if (state is PhoneAuthLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/liyu_logo.png",
                      width: 180.w,
                      height: 140.h,
                    ),
                    SizedBox(height: 120.h),

                    // Label
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            getTranslation(context, "Enter Phone No"),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w800,
                                      color: kGreyColor,
                                    ),
                          ),
                        ],
                      ),
                    ),

                    /// Phone input field
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kLightGreyColor,
                      ),
                      child: SizedBox(
                        width: 1.sw,
                        height: 68.r,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.h,
                                vertical: 4.h,
                              ),
                              child: SizedBox(
                                width: 50.r,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
//                                     IntlPhoneField(
//     decoration: const InputDecoration(
//         labelText: 'Phone Number',
//         border: OutlineInputBorder(
//             borderSide: BorderSide(),
//         ),
//     ),
//     initialCountryCode: 'IN',
//     onChanged: (phone) {
//         print(phone.completeNumber);
//     },
// ),
                                    Text(
                                      "+251",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.sp,
                                            color: kPrimaryColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 4.h),
                                child: TextFormField(
                                  controller: _phoneController,
                                  onChanged: (value) {},
                                  keyboardType: TextInputType.phone,
                                  enableSuggestions: true,
                                  maxLength: 10,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    AppButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Logger().d(_phoneController.text.length);
                          _sendOtp(
                          phoneNumber: _phoneController.text,
                          context: context);
                        }
                      },
                      child: Text(
                        getTranslation(context, "next_text"),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: kBaseColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    ));
  }
}
