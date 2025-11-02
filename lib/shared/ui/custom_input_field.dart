import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/theme/app_theme.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  final TextInputType textInputType;
  final GlobalKey formKey;
  final Function(String)? onChangedHandle;

  const CustomInputField({
    Key? key,
    required this.hintText,
    required this.formKey,
    this.textInputType = TextInputType.text,
    this.onChangedHandle,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  _handleFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = AppTheme.colors;
    final textStyles = AppTheme.textStyles;

    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: _hasFocus
            ? Border(
                left: BorderSide(
                width: 3,
                color: Colors.amber.withValues(alpha: 0.8),
              ))
            : null,
      ),
      child: TextField(
        key: widget.formKey,
        focusNode: _focusNode,
        onChanged: widget.onChangedHandle,
        cursorColor: appColors.cursor,
        cursorWidth: 3,
        style: textStyles.menu,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: _hasFocus ? textStyles.hintTextSelected : textStyles.hintTextNotSelected,
          filled: true,
          fillColor: _hasFocus ? Colors.amber.withValues(alpha: 0.4) : Colors.black54,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
