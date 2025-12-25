import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/home_page/screens/home_page.dart';
import 'package:macros_to_helldivers/shared/translation/translation_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static String routeName = "splash_page";

  @override
  Widget build(BuildContext context) {
    final TranslationProvider translationProvider =
        Provider.of<TranslationProvider>(context, listen: false);

    return FutureBuilder(
      future: translationProvider.init(context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return SafeArea(
              child: Scaffold(
                body: Image.asset(
                  "assets/images/home_background.webp",
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
            );

          case ConnectionState.done:
          default:
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            });

            return Container();
        }
      },
    );
  }
}
