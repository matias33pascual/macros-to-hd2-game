import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/theme/exports_theme.dart';

enum VerticalBarSide { left, right }

class VerticalBar extends StatelessWidget {
  final double height;
  final VerticalBarSide side;

  const VerticalBar({
    super.key,
    required this.height,
    required this.side,
  });

  @override
  Widget build(BuildContext context) {
    final decorationEffects = AppTheme.decorationEffects;
    final colors = AppTheme.colors;

    return Container(
      width: 8,
      height: height,
      decoration: BoxDecoration(
        border: Border(
          left: side == VerticalBarSide.left
              ? BorderSide(color: colors.borderGray, width: 1)
              : BorderSide.none,
          right: side == VerticalBarSide.right
              ? BorderSide(color: colors.borderGray, width: 1)
              : BorderSide.none,
          top: BorderSide(color: colors.borderGray, width: 1),
          bottom: BorderSide(color: colors.borderGray, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 2, top: 2, bottom: 2),
        child: Container(
          decoration: BoxDecoration(
            gradient: decorationEffects.verticalLinearGradientGrey,
          ),
        ),
      ),
    );
  }
}
