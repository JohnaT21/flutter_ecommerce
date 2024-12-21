import 'package:flutter/material.dart';

import '../../config/constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key, this.onPressed, required this.child, this.backgroundColor})
      : super(key: key);

  /// [VoidCallback] called when button is pressed.
  /// Button is disabled when null.
  final VoidCallback? onPressed;

  /// [Widget] displayed on the button.
  final Widget child;

  /// Background color.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onPressed != null ? 1 : 0.6,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
              if (states.contains(MaterialState.disabled)) {
                return kGreyColor;
              }
              return backgroundColor ?? Theme.of(context).primaryColor;
            },
          ),
          foregroundColor: MaterialStateProperty.all(kBaseColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
