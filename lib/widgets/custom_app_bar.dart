import 'package:flutter/material.dart';
import 'package:unibus/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, this.title = '', this.leading, this.titleWidget});

  final String title;
  final Widget? leading;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ??
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold, color: form)),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
