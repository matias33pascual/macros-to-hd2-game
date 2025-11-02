import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/shared/ui/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color;
  final Widget? actionButton;
  final VoidCallback? onBackButtonPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.color = Colors.black,
    this.actionButton,
    this.onBackButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: color,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 28,
        ),
        color: Colors.white,
        onPressed: () {
          if (onBackButtonPressed != null) {
            onBackButtonPressed!();
          }

          Navigator.pop(context);
        },
      ),
      title: CustomText(text: title, size: 24),
      actions: actionButton != null ? [actionButton!] : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
