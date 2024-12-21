import 'package:flutter/material.dart';

class RoundedOutlinedButton extends StatelessWidget {
  const RoundedOutlinedButton(
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
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          foregroundColor: MaterialStateProperty.all(
            Theme.of(context).primaryColor,
          ),
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
