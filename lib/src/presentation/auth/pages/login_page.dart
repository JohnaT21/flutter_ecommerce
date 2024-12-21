import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/config/validations.dart';
import 'package:ecommerce/src/core/helpers/snack_bar_service.dart';
import 'package:ecommerce/src/core/helpers/social_signin.dart';
import 'package:ecommerce/src/di/injector.dart';
import 'package:ecommerce/src/presentation/auth/blocs/auth/auth_bloc_bloc.dart';
import 'package:ecommerce/src/presentation/auth/pages/forget_password_email_page.dart';
import 'package:ecommerce/src/presentation/auth/pages/phone_login_page.dart';
import 'package:ecommerce/src/presentation/shared_widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/helpers/localization_helper.dart';
import '../../bottom_navigator/pages/bottom_navigator_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login_page";

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate.fixed(
              [
                DecoratedBox(
                  decoration: const BoxDecoration(color: kLightGreyColor),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),

                        /// Illustration image
                        SvgPicture.asset(
                          "assets/svgs/logo_text.svg",
                          height: 240.h,
                          width: 220.h,
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  "${getTranslation(context, "login_text")}   ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kDarkTextColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),

                /// Phone Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36.w),
                  child: TextFormField(
                    controller: _phoneController,
                    validator: requiredValidator,
                    // maxLength: 9,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      labelStyle: const TextStyle(color: kGreyColor),
                      // prefix: Text("+251 - "),
                      focusColor: kPrimaryColor,
                      labelText:
                          "${getTranslation(context, "Phone")}/${getTranslation(context, "email_text")}",
                      prefixIcon: const Icon(
                        Icons.account_box_outlined,
                        color: kDarkTextColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),

                /// Password Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36.w),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: passwordValidator,
                    obscureText: !isPasswordVisible,
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
                  height: 40.h,
                ),

                BlocConsumer<AuthBloc, AuthBlocState>(
                  listener: (context, state) {
                    if (state is AuthLoaded && state.status == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content:
                              Text(getTranslation(context, "success_text")),
                        ),
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          BottomNavigatorPage.routeName, (route) => false);
                    }

                    // error logging in
                    else if (state is AuthError) {
                      SnackBarService.showErrorSnackBar(content: state.message);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(
                      //       state.message,
                      //     ),
                      //   ),
                      // );
                    }
                  },
                  builder: (_, state) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Visibility(
                      visible: state is! AuthLoading,
                      replacement: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints.tight(const Size(
                              40,
                              40,
                            )),
                            child: const CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      child: RoundedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            sl.get<AuthBloc>().add(LoginUser(
                                email: _phoneController.text,
                                password: _passwordController.text));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(14.h),
                          child: Text(
                            getTranslation(context, "login_text"),
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ForgetPasswordEmailPage.routeName,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${getTranslation(context, "forgot_password_text")}?",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor),
                    ),
                  ),
                ),

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
                        "${getTranslation(context, "no_account_text")}?",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(PhoneLoginPage.routeName);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            getTranslation(context, "register_now_text"),
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

                /// Divider
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 36.w,
                    vertical: 6.h,
                  ),
                  child: const Divider(
                    thickness: 1,
                  ),
                ),

                // Text(
                //   getTranslation(context, "continue_with_text"),
                //   textAlign: TextAlign.center,
                //   style: Theme.of(context).textTheme.bodyLarge,
                // ),

                /// Social sign in
                //    Padding(
                //        padding: EdgeInsets.symmetric(
                //          horizontal: 36.w,
                //          vertical: 6.h,
                //        ),
                //        child: Row(
                //          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //          children: [
                //            Flexible(
                //              child: SocialSignInButton(
                //                name: "Google",
                //                icon: "assets/svgs/google_icon.svg",
                //                onPressed: () => signinWithGoogle(context),
                //              ),
                //            ),
                //            SizedBox(
                //              width: 8.w,
                //            ),
                //            Flexible(
                //              child: SocialSignInButton(
                //                name: "Facebook",
                //                icon: "assets/svgs/fb_icon.svg",
                //                onPressed: () {},
                //              ),
                //            ),
                //          ],
                //        )),
              ],
            ))
          ],
        ),
      ),
    );
  }

  signinWithGoogle(context) async {
    print("google sign in");
    String? token = await signInWithGoogle(context: context);
    print(token);
    sl<AuthBloc>().add(GoogleSignInEvent(
      token: token!,
    ));
  }
}
