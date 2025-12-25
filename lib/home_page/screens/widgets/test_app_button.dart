import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/shared/ui/custom_button.dart';
import 'package:provider/provider.dart';

import '../../../shared/translation/translation_provider.dart';

class TestAppButton extends StatelessWidget {
  const TestAppButton({super.key});

  @override
  Widget build(BuildContext context) {
    final TranslationProvider translationProvider = Provider.of<TranslationProvider>(context);

    return CustomButton(
      color: CustomButtonColors.yellow,
      text: translationProvider.translationTextOf?["test_app_button"],
      height: 50,
      fontSize: 14,
    );
  }
}
