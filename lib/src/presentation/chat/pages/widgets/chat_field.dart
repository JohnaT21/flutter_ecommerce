import 'package:ecommerce/src/config/constants.dart';
import 'package:ecommerce/src/presentation/chat/pages/widgets/price_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatField extends StatefulWidget {
  const ChatField({Key? key}) : super(key: key);

  @override
  ChatFieldState createState() => ChatFieldState();
}

class ChatFieldState extends State<ChatField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        child: Column(children: [
          const Spacer(),
          SizedBox(
              height: 80.h,
              child: Flexible(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return const PriceCard();
                      }),
                      separatorBuilder: ((context, index) {
                        return SizedBox(
                          width: 2.w,
                        );
                      }),
                      itemCount: 6))),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: kBaseColor,
                      border: Border.all(width: 1.w, color: kGreyBorderColor)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                          child: const Icon(
                            Icons.photo_camera,
                            color: kDarkIconColor,
                          ),
                          onTap: () {}),
                      SizedBox(
                        width: 8.w,
                      ),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "minimum 1800 ",
                              hintStyle: TextStyle(color: kGreyHintColor),
                              border: InputBorder.none),
                        ),
                      ),
                      InkWell(
                          child: const Icon(
                            Icons.thumb_up_sharp,
                            color: kDarkIconColor,
                          ),
                          onTap: () {}),
                      SizedBox(
                        width: 15.w,
                      ),
                      InkWell(
                        child: const Icon(
                          Icons.keyboard_voice,
                          color: kDarkIconColor,
                        ),
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 8.w,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              InkWell(
                child: const Icon(
                  Icons.send,
                ),
                onTap: () {},
              )
            ],
          ),
        ]));
  }
}
