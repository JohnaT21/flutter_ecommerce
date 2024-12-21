import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/presentation/chat/pages/single_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatItem extends StatefulWidget {
  final String name;
  final String text;
  final String time;
  final String img;
  final bool isRead;

  const ChatItem(
      {Key? key,
      required this.name,
      required this.text,
      required this.img,
      required this.isRead,
      required this.time})
      : super(key: key);

  @override
  ChatItemState createState() => ChatItemState();
}

class ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          SingleChatPage.routeName,
        );
      },
      child: DecoratedBox(
          decoration:
              BoxDecoration(color: widget.isRead ? kBaseColor : kGreyBgColor),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  child: Image.asset(widget.img),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 80.w,
                          child: Text(
                            widget.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(width: 130.w),
                        Text(
                          widget.time,
                          style: const TextStyle(color: kDarkGreyColor),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: Text(
                            widget.text,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: kDarkGreyColor),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        widget.isRead
                            ? const SizedBox()
                            : Container(
                                height: 30.h,
                                width: 30.w,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: kBlueColor),
                                child: Center(
                                  child: Text(
                                    "10",
                                    style: TextStyle(
                                        color: kBaseColor, fontSize: 14.sp),
                                  ),
                                ),
                              )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
