import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.size,
      required this.controller,
      required this.labelText, 
      required this.icon
      });

  final Size size;
  final TextEditingController controller;
  final String labelText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.w),
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // color: AppColors.Black,
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'required';
          }
          return null;
        },
        // style: TextStyle(color: AppColors.White.withOpacity(0.5)),
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            labelText: labelText,
            enabledBorder: InputBorder.none,
            labelStyle: GoogleFonts.montserrat(
              // color: AppColors.White.withOpacity(0.5),
            )),
      ),
    );
  }
}
