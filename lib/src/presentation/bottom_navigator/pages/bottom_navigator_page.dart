import 'package:ecommerce/src/presentation/chat/pages/chat_page.dart';
import 'package:ecommerce/src/presentation/favorite/pages/favorite_page.dart';
import 'package:ecommerce/src/presentation/home/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../../../config/constants.dart';
import '../../../core/helpers/localization_helper.dart';
import '../../account/pages/profile_page.dart';
import '../../sell/pages/sell_page.dart';

class BottomNavigatorPage extends StatefulWidget {
  static const routeName = "/bottom_navigator_page";

  const BottomNavigatorPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigatorPage> createState() => _BottomNavigatorPageState();
}

class _BottomNavigatorPageState extends State<BottomNavigatorPage> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomePage(),
    const FavoritePage(),
    const SellPage(),
    // const ChatPage(),
    const ProfilePage(),
  ];
  @override
  void initState() {
    // BlocProvider.of<FavoriteBloc>(context).add(GetAllFavoriteEvent());
    // BlocProvider.of<ChatBloc>(context).add(GetChatListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: screens.elementAt(currentIndex)),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    List<BottomNavigationBarItem> bottomBarItems = [
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.home_outlined,
          size: 32,
        ),
        label: getTranslation(context, "home_text"),
        activeIcon: const Icon(
          Icons.home_filled,
          size: 40,
        ),
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.favorite_outline,
          size: 32,
        ),
        label: getTranslation(context, "favorite_text"),
        activeIcon: const Icon(
          Icons.favorite,
          size: 40,
        ),
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.add_circle_outline,
          size: 32,
        ),
        label: getTranslation(context, "sell_text"),
        activeIcon: const Icon(
          Icons.add_circle,
          size: 40,
        ),
      ),
      // BottomNavigationBarItem(
      //   icon: const Icon(
      //     Icons.chat_outlined,
      //     size: 32,
      //   ),
      //   label: getTranslation(context, "chat_text"),
      //   activeIcon: const Icon(
      //     Icons.chat,
      //     size: 40,
      //   ),
      // ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.person_outline,
          size: 32,
        ),
        label: getTranslation(context, "profile_text"),
        activeIcon: const Icon(
          Icons.person,
          size: 40,
        ),
      ),
    ];
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      backgroundColor: kBaseColor,
      currentIndex: currentIndex,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.black54,
      iconSize: 24,
      unselectedLabelStyle:
          const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
      selectedLabelStyle:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      onTap: (index) => setState(() => currentIndex = index),
      items: bottomBarItems,
    );
  }
}
