import 'package:ecommerce/src/presentation/auth/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../../core/helpers/localization_helper.dart';

class DialogNotLoggedIn extends StatelessWidget {
  const DialogNotLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AlertDialog(
      title: Text(getTranslation(context,"Sign in")), // To display the title it is optional
      content: const Text(
          'Please Sign in to continue'), // Message which will be pop up on the screen
      // Action widget which will provide the user to acknowledge the choice
      actions: [
        ElevatedButton(
          // FlatButton widget is used to make a text to work like a button
          //  textColor: Colors.black,
          onPressed:
              () {}, // function used to perform after pressing the button
          child: Text(getTranslation(context, "CANCEL")),
        ),
        ElevatedButton(
          //textColor: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, LoginPage.routeName);
          },
          child: Text(getTranslation(context, "Sign in")),
        ),
      ],
    ));
  }
}
