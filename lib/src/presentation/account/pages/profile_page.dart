import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/config/local_storage.dart';
import 'package:ecommerce/src/presentation/auth/blocs/auth/auth_bloc_bloc.dart';
import 'package:ecommerce/src/presentation/auth/pages/login_page.dart';
import 'package:ecommerce/src/presentation/shared_widgets/default_app_bar.dart';
import 'package:ecommerce/src/presentation/shared_widgets/dialog_not_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../core/helpers/localization_helper.dart';
import '../../products/pages/products_page.dart';
import '../bloc/account_bloc.dart';
import 'change_password_page.dart';
import 'edit_profile_page.dart';
import 'languages_page.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = "/profile_page";

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthBlocState>(builder: (context, state) {
      if (state is AuthenticationAuthenticated || TOKEN != "") {
        return BlocConsumer<AccountBloc, AccountState>(
            bloc: BlocProvider.of<AccountBloc>(context)..add(GetAccountEvent()),
            listener: (context, state) {
              if (state is GetAccountSuccess) {
              } else if (state is GetAccountLoading) {
                Logger().d("Loading....");
              } else if (state is GetAccountError) {
                Logger().d(state.msg);
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    DefaultAppBar(
                      title: getTranslation(context, "profile_text"),
                      actions: commonActions(context),
                      hasLeading: false,
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate.fixed(
                        [
                          state is GetAccountError
                              ? Container(
                                  color: kSecondaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(state.msg),
                                  ))
                              : const SizedBox(),
                          SizedBox(
                            height: 40.h,
                          ),

                          /// Profile Image
                          CircleAvatar(
                              backgroundColor: kPrimaryColor,
                              radius: 72.r,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(170)),
                                child: CachedNetworkImage(
                                  imageUrl: state is GetAccountSuccess
                                      ? '$BASE_API_URL_IMAGE/${state.profileModel.data.imageURL}'
                                      : '',
                                  fit: BoxFit.cover,
                                  width: 145.r,
                                  height: 145.r,
                                  errorWidget: (context, value, data) =>
                                      SizedBox(
                                    width: 100.r,
                                    height: 85.r,
                                    child: const Center(
                                        child: Icon(Icons
                                            .image_not_supported_outlined)),
                                  ),
                                  placeholder: (context, value) => Image.asset(
                                    'assets/images/liyu_logo.png',
                                    fit: BoxFit.cover,
                                    width: 190.r,
                                    height: 85.r,
                                  ),
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 60.h,
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.person_outline,
                                    color: kPrimaryColor,
                                    size: 32,
                                  ),
                                  title: Text(
                                    getTranslation(context, "account_text"),
                                    style: TextStyle(
                                      color: kDarkTextColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: kDarkTextColor,
                                  ),
                                  onTap: state is GetAccountSuccess
                                      ? () async {
                                          Navigator.of(context).pushNamed(
                                              EditProfilePage.routeName,
                                              arguments: state.profileModel);
                                        }
                                      : null,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 6.h,
                                    horizontal: 16.w,
                                  ),
                                  child: const Divider(
                                    thickness: 1.2,
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.language_outlined,
                                    color: kPrimaryColor,
                                    size: 32,
                                  ),
                                  title: Text(
                                    getTranslation(context, "Languages"),
                                    style: TextStyle(
                                      color: kDarkTextColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: kDarkTextColor,
                                  ),
                                  onTap: () async {
                                    Navigator.pushNamed(
                                      context,
                                      LanguagesPage.routeName,
                                    );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 6.h,
                                    horizontal: 16.w,
                                  ),
                                  child: const Divider(
                                    thickness: 1.2,
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.list_alt_outlined,
                                    color: kPrimaryColor,
                                    size: 32,
                                  ),
                                  title: Text(
                                    getTranslation(context, "My Items"),
                                    style: TextStyle(
                                      color: kDarkTextColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: kDarkTextColor,
                                  ),
                                  onTap: () async {
                                    Navigator.pushNamed(
                                      context,
                                      MyProductsPage.routeName,
                                    );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 6.h,
                                    horizontal: 16.w,
                                  ),
                                  child: const Divider(
                                    thickness: 1.2,
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.list_alt_outlined,
                                    color: kPrimaryColor,
                                    size: 32,
                                  ),
                                  title: Text(
                                    getTranslation(
                                        context, "change_password_text"),
                                    style: TextStyle(
                                      color: kDarkTextColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: kDarkTextColor,
                                  ),
                                  onTap: () async {
                                    Navigator.pushNamed(
                                      context,
                                      ChangePasswordPage.routeName,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 1.sw,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: OutlinedButton(
                                onPressed: () {
                                  Storage.removeValue("TOKEN");
                                  Storage.removeValue("USERID");
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    LoginPage.routeName,
                                    (route) => false,
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(14.h),
                                  child: Text(
                                    getTranslation(context, "logout_text"),
                                    style: TextStyle(
                                      color: kDarkTextColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      } else {
        return const DialogNotLoggedIn();
      }
    });
  }
}
