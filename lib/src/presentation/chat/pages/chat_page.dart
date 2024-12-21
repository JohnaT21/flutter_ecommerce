import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/localization_helper.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = "/chat_page";
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<AuthBloc, AuthBlocState>(builder: (context, state) {
    // if (state is AuthenticationAuthenticated || TOKEN != "") {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBaseColor,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: Text(
            getTranslation(context, "chats_text"),
            style: const TextStyle(color: kDarkTextColor),
          ),
          actions: [
            // Padding(
            //   padding: EdgeInsets.fromLTRB(4.w, 0.h, 4.w, 0.h),
            //   child: const Icon(
            //     Icons.shopping_cart,
            //     size: 28,
            //     color: kTertiaryColor,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.fromLTRB(4.w, 0.h, 16.w, 0.h),
              child: const Icon(
                Icons.notifications,
                size: 28,
                color: kTertiaryColor,
              ),
            ),
          ],
        ),
        body: const Center(
          child: Text('UNDER DEV'),
        )

        // BlocConsumer<ChatBloc, ChatState>(
        //   listener: (context, state) {
        //     Logger().d(state);
        //   },
        //   builder: (context, state) {
        //     if (state is GetChatlistLoading) {
        //       return Center(
        //         child: Text(getTranslation(context, "Coming soon!")),
        //       );
        //     }
        //     if (state is GetChatlistError) {
        //       return Center(child: Text(state.msg));
        //     }
        //     return Padding(
        //         padding: EdgeInsets.symmetric(vertical: 20.h),
        //         child: state is GetChatlistSuccess
        //             ? ListView.separated(
        //                 scrollDirection: Axis.vertical,
        //                 itemCount: 4,
        //                 itemBuilder: ((context, index) {
        //                   return ChatItem(
        //                       name: "abebe abebe",
        //                       isRead: false,
        //                       text:
        //                           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
        //                       img: "assets/images/profile.png",
        //                       time: "02:30PM ");
        //                 }),
        //                 separatorBuilder: (BuildContext context, int index) {
        //                   return SizedBox(
        //                     height: 3.h,
        //                   );
        //                 },
        //               )
        //             : const Center(
        //                 child: Text("under Development"),
        //               ));
        //   },
        // ),

        );
    // } else {
    // return const DialogNotLoggedIn();
    // }
    // });
  }
}
