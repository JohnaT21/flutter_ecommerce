import 'package:ecommerce/src/config/validations.dart';
import 'package:ecommerce/src/presentation/auth/blocs/auth/auth_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/constants.dart';
import '../../../config/env.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../../di/injector.dart';
import '../../shared_widgets/rounded_button.dart';

class ChangePasswordPage extends StatefulWidget {
  static const String routeName = "/change_password_page";
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

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
                  SizedBox(
                    height: 160.h,
                  ),
                  Text(
                    getTranslation(context,"change_password_text"),
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
                      controller: _oldPasswordController,
                      validator: passwordValidator,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        labelStyle:const  TextStyle(color: kGreyColor),
                        focusColor: kPrimaryColor,
                        labelText: getTranslation(context, "old_pwd_text"),
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

                  /// Password Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36.w),
                    child: TextFormField(
                      controller: _newPasswordController,
                      validator: passwordValidator,
                      obscureText: !isPasswordVisible,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                        labelStyle: const TextStyle(color: kGreyColor),
                        focusColor: kPrimaryColor,
                        labelText: getTranslation(context, "new_pwd_text"),
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

                  BlocConsumer<AuthBloc, AuthBlocState>(
                      listener: (context, state) {
                    // if success
                    if (state is ChangePasswordLoaded) {
                      if (state.status) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message,
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message,
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    }

                    // error logging in
                    else if (state is AuthError) {}
                  }, builder: (context, state) {
                    //
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: RoundedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true &&
                              state is! AuthLoading) {
                            sl<AuthBloc>().add(ChangePassword(
                              userId: USERID,
                              oldPassword: _oldPasswordController.text,
                              newPassword: _newPasswordController.text,
                            ));
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(14.h),
                          child: Text(
                            state is! ChangePasswordLoading
                                ? getTranslation(context, "change_password_text")
                                : getTranslation(context, "login_text"),
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
