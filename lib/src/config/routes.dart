import 'package:ecommerce/src/domain/entities/product_category.dart';
import 'package:ecommerce/src/domain/entities/profile_model.dart';
import 'package:ecommerce/src/presentation/auth/pages/forget_password_email_page.dart';
import 'package:ecommerce/src/presentation/auth/pages/login_page.dart';
import 'package:ecommerce/src/presentation/bottom_navigator/pages/bottom_navigator_page.dart';
import 'package:ecommerce/src/presentation/chat/pages/chat_page.dart';
import 'package:ecommerce/src/presentation/chat/pages/single_chat_page.dart';
import 'package:ecommerce/src/presentation/favorite/pages/favorite_page.dart';
import 'package:ecommerce/src/presentation/home/pages/category_page.dart';
import 'package:ecommerce/src/presentation/home/pages/home_page.dart';
import 'package:ecommerce/src/presentation/notifications/pages/notifications_page.dart';
import 'package:ecommerce/src/presentation/products/pages/product_option_page.dart';
import 'package:ecommerce/src/presentation/products/pages/product_page.dart';
import 'package:ecommerce/src/presentation/products/pages/products_page.dart';
import 'package:ecommerce/src/presentation/products/pages/search_filters_page.dart';
import 'package:ecommerce/src/presentation/search/pages/search_results.dart';
import 'package:ecommerce/src/presentation/splash/splash_page.dart';
import 'package:flutter/material.dart';

import '../presentation/account/pages/change_password_page.dart';
import '../presentation/account/pages/edit_profile_page.dart';
import '../presentation/account/pages/languages_page.dart';
import '../presentation/account/pages/profile_page.dart';
import '../presentation/auth/pages/forget_password_page.dart';
import '../presentation/auth/pages/otp_page.dart';
import '../presentation/auth/pages/phone_login_page.dart';
import '../presentation/auth/pages/register_page.dart';
import '../presentation/product_detail/pages/product_detail_page.dart';
import '../presentation/sell/pages/options_page.dart';
import '../presentation/sell/pages/product_category_page.dart';
import '../presentation/sell/pages/product_sub_category_page.dart';
import '../presentation/sell/pages/sell_page.dart';
import '../presentation/sell/pages/values_page.dart';

class AppRouter {
  MaterialPageRoute? onGeneratedRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const SplashPage());
      case LoginPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const LoginPage());
      case ForgetPasswordPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const ForgetPasswordPage());
      case RegisterPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const RegisterPage());
      case BottomNavigatorPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const BottomNavigatorPage());
      case HomePage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const HomePage());
      case FavoritePage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const FavoritePage());
      case SellPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const SellPage());
      case ChatPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const ChatPage());
      case ProfilePage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const ProfilePage());
      case ProductDetailPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const ProductDetailPage());
      case NotificationPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const NotificationPage());
      case MyProductsPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const MyProductsPage());
      case SearchFiltersPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => SearchFiltersPage());
      case SearchResultsPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const SearchResultsPage());
      case EditProfilePage.routeName:
        ProfileModel data = routeSettings.arguments as ProfileModel;
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => EditProfilePage(
                  profilModel: data,
                ));
      case ProductOptionPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const ProductOptionPage());
      case ProductCategoryPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const ProductCategoryPage());
      case ProductSubCategoryPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const ProductSubCategoryPage());
      case CategoryPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const CategoryPage());
      case OptionsPaage.routeName:
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => OptionsPaage(args: args as List<OptionElement>));
      case SingleChatPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const SingleChatPage());
      case ValuesPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const ValuesPage());
      case ForgetPasswordEmailPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const ForgetPasswordEmailPage());
      case ProductPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const ProductPage());
      ////////
      ///

      // case ProductDetailFavPage.routeName:
      //   return MaterialPageRoute(
      //       settings: routeSettings,
      //       builder: (_) => ProductDetailFavPage(
      //           ));
      case PhoneLoginPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const PhoneLoginPage());
      case OTPVerificationPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const OTPVerificationPage());
      case LanguagesPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const LanguagesPage());
      case ChangePasswordPage.routeName:
        return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const ChangePasswordPage());
    }
    return null;
  }
}
