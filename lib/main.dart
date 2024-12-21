import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/config/local_storage.dart';
import 'package:ecommerce/src/config/routes.dart';
import 'package:ecommerce/src/data/data_sources/localization_service.dart';
import 'package:ecommerce/src/di/injector.dart';
import 'package:ecommerce/src/presentation/account/bloc/account_bloc.dart';
import 'package:ecommerce/src/presentation/auth/blocs/auth/auth_bloc_bloc.dart';
import 'package:ecommerce/src/presentation/auth/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:ecommerce/src/presentation/auth/blocs/register/register_bloc.dart';
import 'package:ecommerce/src/presentation/bottom_navigator/pages/bottom_navigator_page.dart';
import 'package:ecommerce/src/presentation/chat/bloc/chat_bloc.dart';
import 'package:ecommerce/src/presentation/favorite/bloc/favorite_bloc.dart';
import 'package:ecommerce/src/presentation/home/blocs/category_bloc/category_bloc.dart';
import 'package:ecommerce/src/presentation/home/blocs/category_bloc/category_event.dart';
import 'package:ecommerce/src/presentation/home/blocs/shop_bloc/shop_bloc.dart';
import 'package:ecommerce/src/presentation/home/blocs/sub_category_bloc/sub_category_bloc.dart';
import 'package:ecommerce/src/presentation/localization/bloc/localization_bloc.dart';
import 'package:ecommerce/src/presentation/notifications/bloc/notification_bloc.dart';
import 'package:ecommerce/src/presentation/product_detail/bloc/product_detail_bloc.dart';
import 'package:ecommerce/src/presentation/products/bloc/product_bloc.dart';
import 'package:ecommerce/src/presentation/products/bloc/product_by_sub_category_bloc/product_by_sub_category_bloc.dart';
import 'package:ecommerce/src/presentation/products/bloc/product_filter/product_filter_bloc.dart';
import 'package:ecommerce/src/presentation/sell/bloc/option/option_values_bloc.dart';
import 'package:ecommerce/src/presentation/sell/bloc/sell_bloc.dart';
import 'package:ecommerce/src/presentation/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import 'src/config/themes.dart';
import 'src/core/helpers/snack_bar_service.dart';
import 'src/presentation/products/bloc/product_search/product_search_bloc.dart';
import 'src/presentation/products/bloc/related_product/related_product_bloc.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
bool isFlutterLocalNotificationsInitialized = false;
late AndroidNotificationChannel channel;
final AppRouter appRouter = AppRouter();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  //logMEssage("Notification ", "${message.data}");
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  await serviceLocatorInit();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (_) => sl.get<AuthBloc>()),
          BlocProvider<RegisterBloc>(create: (_) => sl.get<RegisterBloc>()),
          BlocProvider<PhoneAuthBloc>(
              create: (_) => PhoneAuthBloc(phoneAuthRepository: sl())),
          BlocProvider<ProductBloc>(
              create: (_) => sl.get<ProductBloc>()..add(const LoadProducts())),
          BlocProvider<ShopBloc>(create: (_) => sl.get<ShopBloc>()),
          BlocProvider<AccountBloc>(
              create: (_) => sl.get<AccountBloc>()..add(GetAccountEvent())),
          BlocProvider<ChatBloc>(create: (_) => sl.get<ChatBloc>()),
          BlocProvider<OptionValuesBloc>(
            create: (_) => OptionValuesBloc(),
          ),
          BlocProvider<SellBloc>(
              create: (_) =>
                  sl.get<SellBloc>()..add(const GetProductCategoryEvent())),
          BlocProvider<FavoriteBloc>(create: (_) => sl.get<FavoriteBloc>()),
          BlocProvider(
              create: (_) =>
                  CategoryBloc(homeCategory: sl())..add(const GetCategories())),
          BlocProvider(create: (_) => SubCategoryBloc(homeSubCateogry: sl())),
          BlocProvider(
              create: (_) => ProductsBySubcategoryBloc(productRepo: sl())),
          BlocProvider(create: (_) => ShopBloc(shopUseCase: sl())),
          BlocProvider(create: (_) => ProductFilterBloc(productRepo: sl())),
          BlocProvider(create: (_) => ProductSearchBloc(productUsecase: sl())),
          BlocProvider<RelatedProductBloc>(
              create: (_) => RelatedProductBloc(productUsecase: sl())),
          BlocProvider<ProductDetailBloc>(
              create: (_) => ProductDetailBloc(sl())),
          BlocProvider(create: (_) => LocalizationBloc()..add(GetLocale())),
          BlocProvider<NotificationBloc>(
              create: (_) => NotificationBloc(notificationUseCase: sl())
                ..add(const LoadNotifications())),
        ],
        child: BlocBuilder<LocalizationBloc, LocalizationState>(
          builder: (context, state) {
            if (state is LocalizationLoaded) {
              return ScreenUtilInit(
                designSize: const Size(390, 920),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) {
                  return MaterialApp(
                    locale: state.locale,
                    localizationsDelegates: const [
                      Localization.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en', 'US'),
                      Locale('am', 'ET')
                    ],
                    localeResolutionCallback: (deviceLocal, supportedLocals) {
                      for (var locale in supportedLocals) {
                        if (locale.languageCode == deviceLocal!.languageCode &&
                            locale.countryCode == deviceLocal.countryCode) {
                          return deviceLocal;
                        }
                      }
                      return supportedLocals.first;
                    },
                    scaffoldMessengerKey: SnackBarService.scaffoldKey,
                    title: 'Liyu',
                    debugShowCheckedModeBanner: false,
                    theme: Themes.lightTheme,
                    onGenerateRoute: appRouter.onGeneratedRoute,
                    initialRoute: Storage.hasData(TOKEN)
                        ? BottomNavigatorPage.routeName
                        : SplashPage.routeName,
                  );
                },
              );
            }
            return Container();
          },
        ));
  }
}
