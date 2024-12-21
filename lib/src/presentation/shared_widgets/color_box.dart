import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorBox extends StatelessWidget {
  const ColorBox({
    required this.color,
    required this.size,
    this.onPressed,
    this.isSelected,
    Key? key,
  }) : super(key: key);
  final Color color;
  final double size;
  final bool? isSelected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.all(4.r),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: isSelected == true ? kPrimaryColor : kGreyColor,
            ),
          ),
          child: SizedBox(
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
