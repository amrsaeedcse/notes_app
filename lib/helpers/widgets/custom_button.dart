import 'package:flutter/material.dart';
import 'package:note_app/helpers/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.centerWidget,
    required this.backGroundColor,
  });

  final VoidCallback onPressed;

  final Widget centerWidget;

  final Color backGroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(6),
          ),
          backgroundColor: backGroundColor,
          padding: EdgeInsets.zero,
        ),

        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [centerWidget],
        ),
      ),
    );
  }
}
