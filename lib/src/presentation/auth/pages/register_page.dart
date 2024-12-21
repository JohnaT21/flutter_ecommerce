import 'package:ecommerce/src/core/helpers/snack_bar_service.dart';
import 'package:ecommerce/src/presentation/auth/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:ecommerce/src/presentation/auth/blocs/phone_auth/phone_auth_event.dart';
import 'package:ecommerce/src/presentation/auth/blocs/register/register_bloc.dart';
import 'package:ecommerce/src/presentation/bottom_navigator/pages/bottom_navigator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../config/constants.dart';
import '../../../config/validations.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../../data/models/user_model.dart';
import '../../shared_widgets/rounded_button.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = "/register_page";
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final phoneNo = ModalRoute.of(context)!.settings.arguments as String;
    void _sendOtp(
        {required String phoneNumber, required BuildContext context}) {
      final phoneNumberWithCode = "+251$phoneNumber";
      //print(phoneNumberWithCode);
      context.read<PhoneAuthBloc>().add(
            SendOtpToPhoneEvent(
              phoneNumber: phoneNumberWithCode,
            ),
          );
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
          Logger().d(state);
          // if success
          if (state is RegisterLoaded) {
            SnackBarService.showSuccessSnackBar(
                content: "Registration Success!");

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavigatorPage(),
                ),
                (route) => false);
          }
          // error logging in
          if (state is RegisterError) {
            SnackBarService.showErrorSnackBar(content: "unable to register");
          }
        }, builder: (context, state) {
          //
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    SizedBox(
                      height: 160.h,
                    ),
                    Text(
                      getTranslation(context, "Registration"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kDarkTextColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 22.sp,
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),

                    /// First Name Field
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.w),
                      child: TextFormField(
                        controller: _firstNameController,
                        validator: nameValidator,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          labelStyle: const TextStyle(color: kGreyColor),
                          focusColor: kPrimaryColor,
                          labelText: getTranslation(context, "first_name_text"),
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: kDarkTextColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),

                    // Last Name
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.w),
                      child: TextFormField(
                        controller: _lastNameController,
                        validator: nameValidator,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          labelStyle: const TextStyle(color: kGreyColor),
                          focusColor: kPrimaryColor,
                          labelText: getTranslation(context, "last_name_text"),
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: kDarkTextColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    //phone

                    // phone
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.w),
                      child: TextFormField(
                        // controller: _phoneController,
                        readOnly:
                            true, //since the phone is verified, there is no need to modify it.
                        initialValue: phoneNo,
                        validator: phoneValidator,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          labelStyle: const TextStyle(color: kGreyColor),
                          focusColor: kPrimaryColor,
                          labelText: getTranslation(context, "phone_no_text"),
                          prefixIcon: const Icon(
                            Icons.call_outlined,
                            color: kDarkTextColor,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 30.h,
                    ),

                    /// email Field
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.w),
                      child: TextFormField(
                        controller: _emailController,
                        validator: emailValidator,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(color: kGreyColor),
                          focusColor: kPrimaryColor,
                          labelText: getTranslation(context, "email_text"),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: kDarkTextColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),

                    /// Password Field
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.w),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: passwordValidator,
                        obscureText: !isPasswordVisible,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          labelStyle: const TextStyle(color: kGreyColor),
                          focusColor: kPrimaryColor,
                          labelText: getTranslation(context, "password_text"),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: kDarkTextColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),

                    /// Repeat Password Field
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.w),
                      child: TextFormField(
                        controller: _passwordRepeatController,
                        validator: passwordValidator,
                        obscureText: !isPasswordVisible,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          labelStyle: const TextStyle(color: kGreyColor),
                          focusColor: kPrimaryColor,
                          labelText: getTranslation(context, "repeat_pwd_text"),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: kDarkTextColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: state is RegisterLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : RoundedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (_passwordController.text ==
                                      _passwordRepeatController.text) {
                                    final Map<String, dynamic> userJson = {
                                      "first_name": _firstNameController.text,
                                      "last_name": _lastNameController.text,
                                      "email": _emailController.text,
                                      "password": _passwordController.text,
                                      "phone": phoneNo
                                    };

                                    final UserModel user =
                                        UserModel.fromJson(userJson);

                                    print(user);

                                    BlocProvider.of<RegisterBloc>(context).add(
                                      RegisterUser(
                                        userInfo: user,
                                      ),
                                    );

                                    // final accountBloc =
                                    //     BlocProvider.of<AccountBloc>(context);
                                    // final token =
                                    //     await FirebaseMessaging.instance.getToken();
                                    // accountBloc.add(
                                    //     UpdateDeviceToken(deviceToken: token!));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(getTranslation(context,
                                            "Password and Repeat Password does not match")),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(14.h),
                                child: Text(
                                  state is! RegisterLoading
                                      ? getTranslation(context, "continue text")
                                      : getTranslation(context, "Loading"),
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 4.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            getTranslation(context, "Already have an account?"),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(
                                "${getTranslation(context, "login_text")}   ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: kPrimaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// void dispatchRegisterUser({required UserModel userInfo}) {
//   sl.get<RegisterBloc>().add(
//         RegisterUser(
//           userInfo: userInfo,
//         ),
//       );
// }
