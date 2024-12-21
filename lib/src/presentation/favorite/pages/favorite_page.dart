import 'package:ecommerce/src/config/env.dart';
import 'package:ecommerce/src/presentation/favorite/bloc/favorite_bloc.dart';
import 'package:ecommerce/src/presentation/shared_widgets/dialog_not_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../config/constants.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../../di/injector.dart';
import '../../home/blocs/shop_bloc/shop_bloc.dart';
import '../../home/blocs/shop_bloc/shop_event.dart';
import '../../products/widgets/notification_icon.dart';
import '../../shared_widgets/favorite_product_card.dart';

class FavoritePage extends StatefulWidget {
  static const String routeName = "/favorite_page";

  const FavoritePage({super.key});

  @override
  State<StatefulWidget> createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
  }

  void onVisibilityChanged(final VisibilityInfo info) {
    if (info.visibleFraction == 1 && TOKEN != "") {
      BlocProvider.of<ShopBloc>(context).add(const GetShop());
      BlocProvider.of<FavoriteBloc>(context).add(GetAllFavoriteEvent());
    } else if (info.visibleFraction == 0) {
      Logger().d("INVISIBLE");
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: const Key('favorite-visibility-detector'),
        onVisibilityChanged: onVisibilityChanged,
        child: TOKEN != ""
            ? Scaffold(
                appBar: AppBar(
                    backgroundColor: kBaseColor,
                    automaticallyImplyLeading: false,
                    title: Text(
                      getTranslation(context, "favorties_text"),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 24.sp,
                          color: kDarkTextColor,
                          fontFamily: 'roboto'),
                    ),
                    actions: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: NotificationIcon(),
                      ),
                      // IconButton(onPressed: (() {}), icon: Icon(Icons.notifications))
                    ]),
                body: RefreshIndicator(
                  onRefresh: () {
                    return Future(
                        () => sl<FavoriteBloc>().add(GetAllFavoriteEvent()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 5.w, top: 28.h),
                    child: BlocConsumer<FavoriteBloc, FavoriteState>(
                        listener: (context, state) {
                      if (state is LoadingFavoriteState) {
                        const CircularProgressIndicator();
                      }
                      if (state is LoadedFavoriteState) {
                        Logger().d(state.favorites.toJson());
                      }
                    }, builder: (context, state) {
                      print(state);
                      if (state is LoadingFavoriteState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is LoadedFavoriteState) {
                        if (state.favorites.data!.isEmpty) {
                          return Center(
                              child: Text(
                                  "${getTranslation(context, "No favorite found")}\n        ${getTranslation(context, "Add first")}"));
                        }
                        return ListView.builder(
                            itemCount: state.favorites.data!.length,
                            itemBuilder: (context, index) =>
                                FavoriteProductCard(
                                  product:
                                      state.favorites.data![index].product!,
                                ));
                      } else if (state is LoadedFavoriteErrorState) {
                        return Center(child: Text(state.msg));
                      }
                      return const SizedBox();
                    }),
                  ),
                ))
            : const DialogNotLoggedIn());
  }
}
