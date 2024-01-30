import 'package:flutter/material.dart';
import 'package:quote/ui/theme/theme.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.icon,
      this.onTap,
      this.transparent = false,
      this.iconColor = AppColors.primary});
  final IconData icon;
  final bool transparent;
  final Color iconColor;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: transparent ? Colors.transparent : Colors.white,
            borderRadius: BorderRadius.circular(5)),
        child: Icon(
          icon,
          size: 16,
          color: iconColor,
        ),
      ),
    );
  }
}
