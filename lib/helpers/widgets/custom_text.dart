import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.data,
    required this.fontSize,
    required this.fontWeight,
    this.textAlign,
    this.color,
  });

  final String data;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      softWrap: true,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? AppColors.textPrimary,
      ),
    );
  }
}
