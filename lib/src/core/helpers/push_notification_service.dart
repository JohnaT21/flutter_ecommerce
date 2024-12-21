import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';

class PushNotificationService {
  Future initialize(context) async {
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        if (value.data['type'] == "chat") {
          //Get.to(NewOrderDetail(orderNumber: value.data['order_number'].toString()));
        }
      }
    });
    // FirebaseMessaging.instance.getInitialMessage().then((value) => message)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // showFlutterNotification(message);
      if (message.data['type'] == "chat") {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(
                        (MediaQuery
                            .of(context)
                            .size
                            .width / 100) * 2))),
                backgroundColor: Colors.white,
                title: Center(
                  child: Container(
                    child: Text(
                      message.notification!.title!,
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize:
                          (MediaQuery
                              .of(context)
                              .size
                              .height / 100) * 2.3),
                    ),
                  ),
                ),
                actions: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            (MediaQuery
                                .of(context)
                                .size
                                .width / 100) * 8,
                            0,
                            (MediaQuery
                                .of(context)
                                .size
                                .width / 100) * 8,
                            0),
                        child: Text(
                          message.notification!.body!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 15, color: Colors.grey.shade600),
                        ),
                      ),
                      SizedBox(
                        height: (MediaQuery
                            .of(context)
                            .size
                            .height / 100) * 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Close",
                                style: GoogleFonts.inter(
                                  color: Colors.blue,
                                  fontSize:
                                  (MediaQuery
                                      .of(context)
                                      .size
                                      .height / 100) *
                                      2,
                                ),
                              )),
                          Container(
                            width: (MediaQuery
                                .of(context)
                                .size
                                .width / 100) * 0.4,
                            height: (MediaQuery
                                .of(context)
                                .size
                                .height / 100) * 3,
                            margin: EdgeInsets.fromLTRB(
                                (MediaQuery
                                    .of(context)
                                    .size
                                    .width / 100) * 3,
                                0,
                                (MediaQuery
                                    .of(context)
                                    .size
                                    .width / 100) * 3,
                                0),
                            color: Colors.grey[300],
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Get.to(NewOrderDetail(orderNumber: message.data['order_number'].toString()));
                              },
                              child: Text(
                                "View Message",
                                style: GoogleFonts.inter(
                                  color: Colors.blue,
                                  fontSize:
                                  (MediaQuery
                                      .of(context)
                                      .size
                                      .height / 100) *
                                      2,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
        );
      } else {
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text(message.notification!.title!),
        //       content: Text(message.notification!.title!),
        //       actions: [
        //         TextButton(
        //             onPressed: () {
        //               Navigator.pop(context);
        //             },
        //             child: const Text("Close")),
        //       ],
        //     );
        //   },
        // );
        showFlutterNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['type'] == "chat") {

      }
    });
  }

  Future<void> onActionSelected(String value) async {
    switch (value) {
      case 'subscribe':
        {
          print(
            'FlutterFire Messaging Example: Subscribing to topic "fcm_test".',
          );
          await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
          print(
            'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',
          );
        }
        break;
      case 'unsubscribe':
        {
          print(
            'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
          );
          await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
          print(
            'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
          );
        }
        break;
      case 'get_apns_token':
        {
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS) {
            print('FlutterFire Messaging Example: Getting APNs token...');
            String? token = await FirebaseMessaging.instance.getAPNSToken();
            print('FlutterFire Messaging Example: Got APNs token: $token');
          } else {
            print(
              'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
            );
          }
        }
        break;
      default:
        break;
    }
  }

  void subscribeTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic('supplier');
  }
}