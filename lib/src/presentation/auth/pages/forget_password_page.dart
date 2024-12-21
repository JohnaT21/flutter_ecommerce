import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

import '../../../config/constants.dart';
import '../../../config/validations.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../bottom_navigator/pages/bottom_navigator_page.dart';
import '../../shared_widgets/rounded_button.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const String routeName = "/forget_password_page";

  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();

  bool isPhoneValidated = false;

  static final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: kPrimaryColor,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kDarkGreyColor),
    ),
  );

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
                    height: 80.h,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Text(
                      getTranslation(context,"reset_pwd_text"),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Text(
                      isPhoneValidated
                          ? getTranslation(context, "Enter phone number and reset your password")
                          : getTranslation(context, "ወደ ስልክህ የተላከውን የማረጋገጫ ኮድ አስገባ"),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  if (isPhoneValidated) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "+251${_phoneController.text}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(width: 24.w),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isPhoneValidated = false;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.w),
                              child: Text(
                                getTranslation(context, "Change phone number"),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: kPrimaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                  SizedBox(
                    height: 30.h,
                  ),

                  /// Phone Field
                  if (!isPhoneValidated) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.w,
                        vertical: 6.h,
                      ),
                      child: TextFormField(
                        controller: _phoneController,
                        validator: phoneValidator,
                        maxLength: 9,
                        keyboardType: TextInputType.phone,
                        decoration:InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          labelStyle: const TextStyle(color: kGreyColor),
                          prefix: const Text("+251 - "),
                          focusColor: kPrimaryColor,
                          labelText: getTranslation(context, "Phone"),
                          prefixIcon:const Icon(
                            Icons.phone,
                            color: kDarkTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (isPhoneValidated) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.w,
                        vertical: 6.h,
                      ),
                      child: Pinput(
                        length: 6,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: kPrimaryColor.withOpacity(0.6)),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: kBaseColor,
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(
                                color: kPrimaryColor.withOpacity(0.6)),
                          ),
                        ),
                        onCompleted: (code) {
                          Navigator.of(context).pushNamed(
                            BottomNavigatorPage.routeName,
                          );
                        },
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
                          if (!isPhoneValidated) {
                            if (_formKey.currentState?.validate() == true) {
                              setState(() {
                                isPhoneValidated = true;
                              });
                            }
                          } else {
                            Navigator.of(context).pushNamed(
                              BottomNavigatorPage.routeName,
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(14.h),
                          child: Text(
                            !isPhoneValidated ? getTranslation(context, "reset_text") : getTranslation(context,"Verify"),
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
      ),
    );
  }
}
