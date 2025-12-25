import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/shared/ui/custom_text.dart';

enum CustomButtonColors {
  gray,
  yellow,
}

class CustomButton extends StatelessWidget {
  final CustomButtonColors color;
  final String text;
  final double? height;
  final double fontSize;

  const CustomButton({
    super.key,
    required this.color,
    required this.text,
    this.height = 30,
    this.fontSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            color == CustomButtonColors.gray ? Colors.grey.withValues(alpha: 0.5) : Colors.amber.withValues(alpha: 0.5),
        border: Border.all(
          width: 2,
          color: color == CustomButtonColors.yellow
              ? Colors.amber.withValues(alpha: 0.9)
              : Colors.grey.withValues(alpha: 0.7),
        ),
        borderRadius: BorderRadius.zero,
      ),
      width: 130,
      height: height,
      child: Center(
        child: CustomText(
          maxLines: 2,
          text: text,
          size: fontSize,
          textColor: color == CustomButtonColors.yellow ? Colors.yellow[100]! : Colors.grey,
        ),
      ),
    );
  }
}
