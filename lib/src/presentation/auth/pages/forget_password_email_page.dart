import 'package:ecommerce/src/di/injector.dart';
import 'package:ecommerce/src/presentation/auth/blocs/auth/auth_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/constants.dart';
import '../../../config/validations.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../shared_widgets/rounded_button.dart';

class ForgetPasswordEmailPage extends StatefulWidget {
  static const String routeName = "/forget_password_email_page";

  const ForgetPasswordEmailPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordEmailPage> createState() =>
      _ForgetPasswordEmailPageState();
}

class _ForgetPasswordEmailPageState extends State<ForgetPasswordEmailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  bool isEmailValidated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl.get<AuthBloc>(),
        child: BlocConsumer<AuthBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is EmailPasswordResetLoaded) {
              // Success
              if (state.status == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      getTranslation(context, "Reset Email has been sent"),
                    ),
                  ),
                );
              }

              //
              else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      state.message,
                    ),
                  ),
                );
              }

              _emailController.text = "";
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        DecoratedBox(
                          decoration:
                              const BoxDecoration(color: kLightGreyColor),
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
                          height: 80.h,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 26.w),
                          child: Text(
                            getTranslation(context, "reset_pwd_text"),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 22.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),

                        //
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 26.w),
                          child: Text(
                            state is EmailPasswordResetLoaded
                                ? getTranslation(context,
                                    "Reset link has been sent to email")
                                : getTranslation(context,
                                    "Enter an email and reset link will be sent"),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 30.h,
                        ),

                        /// Email Field
                        if (!isEmailValidated) ...[
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 36.w,
                              vertical: 6.h,
                            ),
                            child: TextFormField(
                              controller: _emailController,
                              validator: emailValidator,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                labelStyle: const TextStyle(color: kGreyColor),
                                focusColor: kPrimaryColor,
                                labelText:
                                    getTranslation(context, "email_text"),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: kDarkTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],

                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 1.sw,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.w),
                            child: RoundedButton(
                              onPressed: () {
                                if (state is! EmailPasswordResetLoading) {
                                  dispatchRequestPasswordReset(
                                    email: _emailController.text,
                                  );
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(14.h),
                                child: Text(
                                  state is EmailPasswordResetLoading
                                      ? getTranslation(context, "Loading")
                                      : getTranslation(context, "reset_text"),
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void dispatchRequestPasswordReset({required String email}) {
  sl.get<AuthBloc>().add(
        RequestEmailPasswordReset(
          email: email,
        ),
      );
}
