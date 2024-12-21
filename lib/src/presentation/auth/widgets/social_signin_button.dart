import 'package:ecommerce/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({
    required this.name,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String icon;
  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: kLightGreyColor, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 12.w,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: kDarkTextColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
