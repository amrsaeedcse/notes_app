import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/helpers/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.hint,
    required this.height,
  });

  final TextEditingController textEditingController;
  final String hint;
  final double height;

  final double radius = 8;
  final double borderWidth = 1.2;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: textEditingController,
        expands: true,
        maxLines: null,
        style: GoogleFonts.inter(
          fontSize: 16,
          color: AppColors.textSec,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.textSec,
            fontWeight: FontWeight.w700,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: AppColors.textSec,
              width: borderWidth,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: AppColors.textSec,
              width: borderWidth,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: AppColors.textSec,
              width: borderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: AppColors.textSec,
              width: borderWidth,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(
              color: AppColors.textSec,
              width: borderWidth,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Pls Fill the Field ";
          }
          return null;
        },
      ),
    );
  }
}
