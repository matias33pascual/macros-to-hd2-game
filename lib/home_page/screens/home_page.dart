import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/home_page/providers/exports_providers.dart';
import 'package:macros_to_helldivers/home_page/screens/widgets/exports_widgets.dart';
import 'package:macros_to_helldivers/home_page/screens/widgets/test_app_button.dart';
import 'package:macros_to_helldivers/shared/services/connection_service.dart';
import 'package:macros_to_helldivers/shared/translation/translation_provider.dart';
import 'package:macros_to_helldivers/shared/translation/translation_state.dart';
import 'package:macros_to_helldivers/shared/ui/exports_shared.dart';
import 'package:macros_to_helldivers/stratagems_page/screens/stratagems_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String routeName = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);

    homeProvider.loadDataFromLocalStorate(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeProvider provider = Provider.of<HomeProvider>(context);

    if (provider.state.error) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showMyDialog(context);
        provider.state.error = false;
      });
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: true,
        body: OrientationBuilder(
          builder: (context, orientation) => orientation == Orientation.portrait
              ? Container(
                  color: Colors.white.withValues(alpha: 0.1),
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 10, left: 2, right: 2),
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildMacroTitle(),
                        Stack(
                          children: [
                            const Image(image: AssetImage("assets/images/home_background.webp"), fit: BoxFit.fill),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildConnectForm(context),
                                  const SizedBox(height: 50),
                                  _buildButtons(context),
                                  const SizedBox(height: 60),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          const Text(
                                            "By Matias Pascual",
                                            style: TextStyle(color: Colors.amber, fontSize: 20),
                                            textAlign: TextAlign.end,
                                          ),
                                          const Text(
                                            "matias33pascual@gmail.com",
                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                            textAlign: TextAlign.end,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      // Left Side: Title, Background and Buttons
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/home_background.webp"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 64),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [_buildMacroTitle(), const SizedBox(height: 30), _buildButtons(context)],
                            ),
                          ),
                        ),
                      ),
                      // Right Side: Connection Form and Footer
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          color: Colors.grey.withValues(alpha: 0.2),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Column(mainAxisSize: MainAxisSize.min, children: [_buildConnectForm(context)]),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        "By Matias Pascual",
                                        style: TextStyle(color: Colors.amber, fontSize: 20),
                                        textAlign: TextAlign.end,
                                      ),
                                      const Text(
                                        "matias33pascual@gmail.com",
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context) async {
    final TranslationProvider provider = Provider.of<TranslationProvider>(context, listen: false);

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(24),
        contentPadding: const EdgeInsets.all(24),
        shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.amber, width: 1)),
        title: CustomText(
          maxLines: 10,
          size: 16,
          textAlign: TextAlign.center,
          text: provider.translationTextOf?["error_title"],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              maxLines: 20,
              size: 14,
              textAlign: TextAlign.center,
              text: provider.translationTextOf?["error_message"],
            ),
            const SizedBox(height: 8),
            const CustomText(
              maxLines: 20,
              size: 14,
              textAlign: TextAlign.center,
              strokeColor: Colors.black,
              textColor: Colors.amber,
              text: " Macros to HD2 Game PC",
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: CustomButton(
              color: CustomButtonColors.yellow,
              text: provider.translationTextOf?["close_button"],
              height: 40,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildMacroTitle() {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Padding(
      padding: EdgeInsets.only(top: orientation == Orientation.portrait ? 50 : 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(
                text: "Macros to",
                maxLines: 2,
                size: 35,
                textColor: Colors.white,
                strokeColor: Colors.black.withValues(alpha: 0.8),
                fontFamily: "helldivers",
              ),
              CustomText(
                text: "HD2 Game",
                maxLines: 2,
                size: 55,
                textColor: Colors.amber[400]!,
                strokeColor: Colors.black.withValues(alpha: 0.8),
                fontFamily: "helldivers",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _buildButtons(BuildContext context) {
    TranslationProvider translationProvider = Provider.of<TranslationProvider>(context, listen: false);

    return Column(
      spacing: 12,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Set Language Button
        GestureDetector(
          onTap: () => _showLanguageBottomSheet(context),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: const Border.fromBorderSide(BorderSide(width: 2, color: Colors.grey)),
              color: Colors.grey.withValues(alpha: 0.5),
            ),
            child: Row(
              children: [
                SizedBox(width: 40, child: translationProvider.flagIcon),
                const SizedBox(width: 8),
                CustomText(text: translationProvider.translationTextOf?["language"], size: 16, textColor: Colors.white),
              ],
            ),
          ),
        ),
        // Onboarding modal button
        GestureDetector(
          onTap: () => _showLanguageBottomSheet(context),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: const Border.fromBorderSide(BorderSide(width: 2, color: Colors.grey)),
              color: Colors.grey.withValues(alpha: 0.5),
            ),
            child: Row(
              children: [
                SizedBox(width: 40, child: translationProvider.flagIcon),
                const SizedBox(width: 8),
                CustomText(text: translationProvider.translationTextOf?["language"], size: 16, textColor: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    final TranslationProvider provider = Provider.of<TranslationProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900]!.withValues(alpha: 0.8),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Colors.grey[600]!),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      builder: (context) => ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        children: [
          GestureDetector(
            onTap: () {
              provider.setCurrentLanguage(LanguagesEnum.spanish);
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                SizedBox(width: 40, child: Image.asset("assets/images/flag-argentina.webp")),
                const SizedBox(width: 8),
                const CustomText(text: "ESPAÑOL", size: 16, textColor: Colors.white),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              provider.setCurrentLanguage(LanguagesEnum.portuguese);
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                SizedBox(width: 40, child: Image.asset("assets/images/flag-brasil.webp")),
                const SizedBox(width: 8),
                const CustomText(text: "PORTUGUESE", size: 16, textColor: Colors.white),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              provider.setCurrentLanguage(LanguagesEnum.english);
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                SizedBox(width: 40, child: Image.asset("assets/images/flag-usa.webp")),
                const SizedBox(width: 8),
                const CustomText(text: "ENGLISH", size: 16, textColor: Colors.white),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              provider.setCurrentLanguage(LanguagesEnum.russian);
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                SizedBox(width: 40, child: Image.asset("assets/images/flag-rusia.webp")),
                const SizedBox(width: 8),
                const CustomText(text: "РУССКИЙ", size: 16, textColor: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openDownloadURL() {
    final url = Uri.https('github.com', 'matias33pascual/macros-to-helldivers-pc/releases');

    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _openUserManualURL() {
    String urlUserManual = "";

    final LanguagesEnum currentLanguage = TranslationState.instance.currentLanguage;

    switch (currentLanguage) {
      case LanguagesEnum.russian:
        urlUserManual = "view/manual-macros-ru/página-principal";
        break;

      case LanguagesEnum.portuguese:
        urlUserManual = "view/manual-macros-pt/página-principal";
        break;

      case LanguagesEnum.spanish:
        urlUserManual = "view/manual-macros-es/página-principal";
        break;

      case LanguagesEnum.english:
        urlUserManual = "view/manual-macros-en/página-principal";
        break;
    }

    final url = Uri.https('sites.google.com', urlUserManual);

    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _openVideoURL() {
    final url = Uri.https('youtu.be', 'ff934Jjuvdo');

    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Container _buildConnectForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          _buildPanelTitle(),
          const CustomForm(),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    final HomeProvider provider = Provider.of<HomeProvider>(context, listen: false);
                    final NavigatorState navigator = Navigator.of(context);

                    if (provider.state.port.isEmpty || provider.state.ipAddrress.isEmpty || provider.state.isLoading) {
                      return;
                    }

                    try {
                      ConnectionService.instance
                          .connectToServer(provider.state.ipAddrress, provider.state.port, context)
                          .then((value) {
                            if (value) {
                              navigator.pushNamed(StratagemsPage.routeName);
                            } else {
                              if (kDebugMode) {
                                print("No se pudo conectar al servidor: ConnectionService return false.");
                              }
                              provider.setMessageError(true);
                            }
                          })
                          .onError((error, stackTrace) => throw Exception(error));
                    } catch (error) {
                      if (kDebugMode) {
                        print("No se pudo conectar al servidor: $error.");
                      }
                      provider.setMessageError(true);
                    }
                  },
                  child: const ConnectButton(),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(StratagemsPage.routeName),
                  child: const TestAppButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildPanelTitle() {
    final TranslationProvider provider = Provider.of<TranslationProvider>(context);

    return Column(
      children: [
        CustomText(
          text: provider.translationTextOf?["input_hint"],
          size: 16,
          maxLines: 2,
          textColor: Colors.white,
          strokeColor: Colors.black.withValues(alpha: 0.7),
          textAlign: TextAlign.center,
        ),
        CustomText(
          text: "MACROS TO HD2 Game PC",
          size: 16,
          maxLines: 2,
          textColor: Colors.amber,
          strokeColor: Colors.black.withValues(alpha: 0.7),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
