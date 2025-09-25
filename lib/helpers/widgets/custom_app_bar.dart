import 'package:flutter/material.dart';
import 'package:note_app/helpers/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.suf, this.center, this.pre});
  final Widget? suf;
  final Widget? center;
  final Widget? pre;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backGroundColor,
      centerTitle: true,
      title: center,
      actions: [?suf],
      actionsPadding: EdgeInsets.only(right: 16),
      leading: pre,
      leadingWidth: 20,
      scrolledUnderElevation: null,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(72);
}
