import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color strokeColor;
  final Color textColor;
  final bool useStroke;
  final int maxLines;
  final TextAlign textAlign;
  final String? fontFamily;

  const CustomText({
    super.key,
    required this.text,
    this.size = 12,
    this.strokeColor = Colors.black,
    this.textColor = Colors.white,
    this.useStroke = true,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.fontFamily = "roboto",
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (fontFamily == 'helldivers')
          Text(
            text,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: textAlign,
            style: TextStyle(
                fontFamily: fontFamily ?? "Roboto",
                fontSize: size + 0.2,
                color: Colors.black,
                overflow: TextOverflow.ellipsis),
          ),
        Text(
          text,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign,
          style: TextStyle(
              fontFamily: fontFamily ?? "Roboto", fontSize: size, color: textColor, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
