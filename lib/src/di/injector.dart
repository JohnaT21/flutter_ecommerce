import 'package:dio/dio.dart';
import 'package:ecommerce/src/core/network/network_info.dart';
import 'package:ecommerce/src/data/data_sources/account_datasource.dart';
import 'package:ecommerce/src/data/data_sources/auth_data_source.dart';
// import 'package:ecommerce/src/data/data_sources/auth_datasource.dart';
import 'package:ecommerce/src/data/data_sources/categories_datasource.dart';
import 'package:ecommerce/src/data/data_sources/notification_data_source.dart';
import 'package:ecommerce/src/data/data_sources/product_data_source.dart';
import 'package:ecommerce/src/data/data_sources/product_detail_datasource.dart';
import 'package:ecommerce/src/data/data_sources/sub_category_datasource.dart';
import 'package:ecommerce/src/data/repositories/auth_repo_impl.dart';
import 'package:ecommerce/src/data/repositories/category_repo_impl.dart';
import 'package:ecommerce/src/data/repositories/product_detail_repo_impl.dart';
import 'package:ecommerce/src/data/repositories/product_repo_impl.dart';
import 'package:ecommerce/src/data/repositories/sub_category_repo_impl.dart';
import 'package:ecommerce/src/domain/repositories/account_repo.dart';
import 'package:ecommerce/src/domain/repositories/auth_repo.dart';
import 'package:ecommerce/src/domain/repositories/category_repo.dart';
import 'package:ecommerce/src/domain/repositories/product_detail_repo.dart';
import 'package:ecommerce/src/domain/repositories/product_repo.dart';
import 'package:ecommerce/src/domain/repositories/sub_category_repo.dart';
import 'package:ecommerce/src/domain/usecases/account_usecase.dart';
import 'package:ecommerce/src/domain/usecases/chat_usecase.dart';
import 'package:ecommerce/src/domain/usecases/favorite_usecase.dart';
import 'package:ecommerce/src/domain/usecases/home__sub_category_usecase.dart';
import 'package:ecommerce/src/domain/usecases/home_categories_usecase.dart';
import 'package:ecommerce/src/domain/usecases/product_detail_usecase.dart';
import 'package:ecommerce/src/domain/usecases/product_usecase.dart';
import 'package:ecommerce/src/presentation/account/bloc/account_bloc.dart';
import 'package:ecommerce/src/presentation/auth/blocs/auth/auth_bloc_bloc.dart';
import 'package:ecommerce/src/presentation/auth/blocs/register/register_bloc.dart';
import 'package:ecommerce/src/presentation/home/blocs/category_bloc/category_bloc.dart';
import 'package:ecommerce/src/presentation/home/blocs/sub_category_bloc/sub_category_bloc.dart';
import 'package:ecommerce/src/presentation/localization/bloc/localization_bloc.dart';
import 'package:ecommerce/src/presentation/product_detail/bloc/product_detail_bloc.dart';
import 'package:ecommerce/src/presentation/products/bloc/product_bloc.dart';
import 'package:ecommerce/src/presentation/products/bloc/product_by_sub_category_bloc/product_by_sub_category_bloc.dart';
import 'package:ecommerce/src/presentation/products/bloc/related_product/related_product_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../data/data_sources/chat_data_source.dart';
import '../data/data_sources/favorite_data_source.dart';
import '../data/data_sources/sell_data_source.dart';
import '../data/data_sources/shop_datasource.dart';
import '../data/repositories/account_repo_impl.dart';
import '../data/repositories/chat_repo_impl.dart';
import '../data/repositories/favorite_repo_impl.dart';
import '../data/repositories/notification_repo_impl.dart';
import '../data/repositories/sell_repo_impl.dart';
import '../data/repositories/shop_repo_impl.dart';
import '../domain/repositories/chat_repo.dart';
import '../domain/repositories/favorite_repo.dart';
import '../domain/repositories/notification_repo.dart';
import '../domain/repositories/sell_repo.dart';
import '../domain/repositories/shop_repo.dart';
import '../domain/usecases/notificatio_usecase.dart';
import '../domain/usecases/sell_usecase.dart';
import '../domain/usecases/shop_usecase.dart';
import '../presentation/chat/bloc/chat_bloc.dart';
import '../presentation/favorite/bloc/favorite_bloc.dart';
import '../presentation/home/blocs/shop_bloc/shop_bloc.dart';
import '../presentation/notifications/bloc/notification_bloc.dart';
import '../presentation/products/bloc/product_filter/product_filter_bloc.dart';
import '../presentation/products/bloc/product_search/product_search_bloc.dart';
import '../presentation/sell/bloc/sell_bloc.dart';

final sl = GetIt.instance;

Future<void> serviceLocatorInit() async {
  //socket service
  // SocketService.init();

  accountDI();
  sellDI();
  chatDI();
  favoriteDI();
  shopDI();
  productDetailDI();

  ///Dio
  // sl.registerSingleton<Dio>(Dio());

  // Use cases
  sl.registerLazySingleton(() => ProductUsecase(productRepo: sl()));
  sl.registerLazySingleton(() => NotificationUseCase(notificationRepo: sl()));

  /// Blocs
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(authRepo: sl()));
  sl.registerLazySingleton<RegisterBloc>(() => RegisterBloc(sl()));
  sl.registerLazySingleton<ProductBloc>(() => ProductBloc(productRepo: sl()));
  sl.registerLazySingleton<CategoryBloc>(
      () => CategoryBloc(homeCategory: sl()));
  sl.registerLazySingleton<SubCategoryBloc>(
      () => SubCategoryBloc(homeSubCateogry: sl()));

  sl.registerLazySingleton<ProductsBySubcategoryBloc>(
      () => ProductsBySubcategoryBloc(productRepo: sl()));
  sl.registerLazySingleton(() => ProductFilterBloc(productRepo: sl()));
  sl.registerLazySingleton<ProductSearchBloc>(
      () => ProductSearchBloc(productUsecase: sl()));
  sl.registerLazySingleton<RelatedProductBloc>(
      () => RelatedProductBloc(productUsecase: sl()));
  sl.registerLazySingleton<LocalizationBloc>(() => LocalizationBloc());
  sl.registerLazySingleton<NotificationBloc>(
      () => NotificationBloc(notificationUseCase: sl()));

  /// Repositories
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl(), sl(), sl()));
  sl.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(sl(), sl()));
  sl.registerLazySingleton<NotificationRepo>(
      () => NotificationRepoImpl(sl(), sl()));

  /// data sources
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSource());
  sl.registerLazySingleton<ProductDataSource>(() => ProductDataSource());
  sl.registerLazySingleton<NotificationDataSource>(
      () => NotificationDataSource());

  /// Repositories
  // sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(authDatasource: sl()));
  //sl.registerLazySingleton<CategoryRepoImpl>(() => CategoryRepoImpl(categoryDataSource: sl()));
  sl.registerLazySingleton(() => HomeCategory(categoryRepo: sl()));
  sl.registerLazySingleton<CategoryRepo>(
      () => CategoryRepoImpl(networkInfo: sl(), categoryDataSource: sl()));

  sl.registerLazySingleton(() => HomeSubCateogry(subCategoryRepo: sl()));
  sl.registerLazySingleton<SubCategoryRepo>(() =>
      SubCategoryRepoImpl(networkInfo: sl(), subCategoryDataSource: sl()));

  /// data sources
  sl.registerFactory<CategoryDataSource>(() => CategoryDataSource());
  sl.registerFactory<SubCategoryDataSource>(() => SubCategoryDataSource());

  /// Firebase instances

  /// Dio instance
  ///

  ///Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => GetStorage());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

accountDI() {
  sl.registerFactory(() => AccountBloc(sl()));
  sl.registerFactory(() => AccountUsecase(accountRepo: sl()));
  sl.registerLazySingleton<AccountRepo>(
    () => AccountRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<AccountRemoteDataSource>(
    () => AccountRemoteDataSourceImpl(client: sl()),
  );
}

sellDI() {
  sl.registerFactory(() => SellBloc(productCategoryUsecase: sl()));
  sl.registerFactory(() => SellUsecase(sellRepo: sl()));
  sl.registerLazySingleton<SellRepo>(
    () => SellRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<SellRemoteDataSource>(
    () => SellRemoteDataSourceImpl(client: sl()),
  );
}

productDetailDI() {
  sl.registerFactory(() => ProductDetailBloc(sl()));
  sl.registerFactory(() => ProductDetailUsecase(detailRepo: sl()));
  sl.registerLazySingleton<ProductDetailRepo>(
    () => ProductDetailRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ProductDetailRemoteDataSource>(
    () => ProductDetailRemoteDataSourceImpl(client: sl()),
  );
}

chatDI() {
  sl.registerFactory(() => ChatBloc(sl()));
  sl.registerFactory(() => ChatUsecase(chatRepo: sl()));
  sl.registerLazySingleton<ChatRepo>(
    () => ChatRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(client: sl()),
  );
}

favoriteDI() {
  sl.registerFactory(() => FavoriteBloc(sl()));
  sl.registerFactory(() => FavoriteUsecase(favoriteRepo: sl()));
  sl.registerLazySingleton<FavoriteRepo>(() => FavoriteRepoImpl(sl(), sl()));
  sl.registerLazySingleton<FavoriteDataSource>(() => FavoriteDataSource());
}

shopDI() {
  sl.registerFactory(() => ShopBloc(shopUseCase: sl()));
  sl.registerFactory(() => ShopUseCase(shopRepo: sl()));
  sl.registerLazySingleton<ShopRepo>(() => ShopRepoImpl(sl(), sl()));
  sl.registerLazySingleton<ShopDataSource>(() => ShopDataSource());
}
