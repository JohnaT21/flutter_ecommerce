import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/core/socket/socket_service.dart';
import 'package:ecommerce/src/presentation/chat/pages/widgets/chat_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleChatPage extends StatefulWidget {
  static const String routeName = "/single_chat_page";
  const SingleChatPage({Key? key}) : super(key: key);

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  SocketService service = SocketService();

  @override
  void dispose() {
    super.dispose();
    SocketService.onChatImageReceiveController.close();
    SocketService.onMessageSendStreamController.close();
    SocketService.onMessageReceiveController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBaseColor,
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              child: Image.asset("assets/images/profile.png"),
            ),
            SizedBox(
              width: 20.w,
            ),
            SizedBox(
              width: 190.w,
              child: Text(
                'Elsabet Kurabachew',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: 20.sp,
                    color: kDarkGreyColor,
                    fontFamily: 'roboto'),
              ),
            )
          ],
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kDarkTextColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: StreamBuilder<Object>(
          stream: SocketService.onMessageSendStreamController.stream,
          builder: (context, messageSendState) {
            return StreamBuilder<Object>(
                stream: SocketService.onMessageReceiveController.stream,
                builder: (_, messageReceivedState) {
                  return StreamBuilder<Object>(
                      stream: SocketService.onChatImageReceiveController.stream,
                      builder: (__, chatImageState) {
                        return const ChatField();
                      });
                });
          }),
    );
  }
}
