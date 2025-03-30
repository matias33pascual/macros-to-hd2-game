// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

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
  const HomePage({Key? key}) : super(key: key);

  static String routeName = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(
      context,
      listen: false,
    );

    homeProvider.loadDataFromLocalStorate(context);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final HomeProvider provider = Provider.of<HomeProvider>(context);

    if (provider.state.error) {
      showMyDialog(context);
      provider.state.error = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            _buildBackground(context),
            _buildMacroTitle(),
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog(BuildContext context) async {
    await Future.delayed(Duration.zero);

    if (mounted) {
      final TranslationProvider provider =
          Provider.of<TranslationProvider>(context, listen: false);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.black,
          insetPadding: const EdgeInsets.all(24),
          contentPadding: const EdgeInsets.all(24),
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.amber, width: 1)),
          title: CustomText(
              maxLines: 10,
              size: 16,
              textAlign: TextAlign.center,
              text: provider.translationTextOf["error_title"]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                  maxLines: 20,
                  size: 14,
                  textAlign: TextAlign.center,
                  text: provider.translationTextOf["error_message"]),
              SizedBox(height: 8),
              CustomText(
                  maxLines: 20,
                  size: 14,
                  textAlign: TextAlign.center,
                  strokeColor: Colors.black,
                  textColor: Colors.amber,
                  text: " Macros to HD2 Game PC"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: CustomButton(
                  color: CustomButtonColors.yellow,
                  text: provider.translationTextOf["close_button"],
                  height: 40),
            ),
          ],
        ),
      );
    }
  }

  _buildMacroTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
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
                  strokeColor: Colors.black.withOpacity(0.8),
                  fontFamily: "helldivers"),
              CustomText(
                  text: "HD2 Game",
                  maxLines: 2,
                  size: 55,
                  textColor: Colors.amber[400]!,
                  strokeColor: Colors.black.withOpacity(0.8),
                  fontFamily: "helldivers"),
            ],
          ),
        ],
      ),
    );
  }

  Image _buildBackground(BuildContext context) {
    return Image.asset(
      "assets/images/home_background.webp",
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
    );
  }

  _buildForm(BuildContext context) {
    final translationProvider = Provider.of<TranslationProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 2, right: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              _buildPanel(),
              _buildContent(context),
              Padding(
                padding: const EdgeInsets.only(top: 250, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => _showLanguageBottomSheet(context),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.fromBorderSide(
                                  BorderSide(width: 2, color: Colors.grey),
                                ),
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: translationProvider.flagIcon,
                                  ),
                                  SizedBox(width: 8),
                                  CustomText(
                                    text: translationProvider
                                        .translationTextOf["language"],
                                    size: 16,
                                    textColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: _openUserManualURL,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.fromBorderSide(
                                  BorderSide(
                                      width: 2, color: Colors.orange[500]!),
                                ),
                                color: Colors.orange[300]!.withOpacity(0.5),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    width: 40,
                                    child: Image.asset(
                                        "assets/images/manual.webp"),
                                  ),
                                  SizedBox(width: 8),
                                  CustomText(
                                    text: translationProvider
                                        .translationTextOf["how_to"],
                                    size: 16,
                                    textColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: _openVideoURL,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.fromBorderSide(
                                  BorderSide(width: 2, color: Colors.red[300]!),
                                ),
                                color: Colors.red[500]!.withOpacity(0.5),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    width: 40,
                                    child: Image.asset(
                                        "assets/images/youtube.webp"),
                                  ),
                                  SizedBox(width: 8),
                                  CustomText(
                                    text: translationProvider
                                        .translationTextOf["video_tutorial"],
                                    size: 16,
                                    textColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: _openDownloadURL,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                border: Border.fromBorderSide(
                                  BorderSide(
                                      width: 2, color: Colors.blue[200]!),
                                ),
                                color: Colors.blue[300]!.withOpacity(0.7),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    width: 40,
                                    child: Image.asset(
                                        "assets/images/github_b.webp"),
                                  ),
                                  SizedBox(width: 6),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        CustomText(
                                          text: translationProvider
                                              .translationTextOf["download_pc"],
                                          size: 16,
                                          textColor: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        CustomText(
                                          text: "v1.2.0",
                                          size: 12,
                                        )
                                      ])
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: _openByMeCoffeURL,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                border: Border.fromBorderSide(
                                  BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                color: Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.8),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    width: 40,
                                    child: Text(
                                      '☕',
                                      style: TextStyle(fontSize: 32),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: translationProvider
                                              .translationTextOf["support"],
                                          size: 14,
                                          textColor: Colors.white,
                                          textAlign: TextAlign.center,
                                        ),
                                      ])
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    final TranslationProvider provider =
        Provider.of<TranslationProvider>(context, listen: false);

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.grey[900]!.withOpacity(0.8),
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Colors.grey[600]!),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
        builder: (context) => ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              children: [
                GestureDetector(
                  onTap: () {
                    provider.setCurrentLanguage(LanguagesEnum.spanish);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Image.asset("assets/images/flag-argentina.webp"),
                      ),
                      SizedBox(width: 8),
                      CustomText(
                        text: "ESPAÑOL",
                        size: 16,
                        textColor: Colors.white,
                      ),
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
                      SizedBox(
                        width: 40,
                        child: Image.asset("assets/images/flag-brasil.webp"),
                      ),
                      SizedBox(width: 8),
                      CustomText(
                        text: "PORTUGUESE",
                        size: 16,
                        textColor: Colors.white,
                      ),
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
                      SizedBox(
                        width: 40,
                        child: Image.asset("assets/images/flag-usa.webp"),
                      ),
                      SizedBox(width: 8),
                      CustomText(
                        text: "ENGLISH",
                        size: 16,
                        textColor: Colors.white,
                      ),
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
                      SizedBox(
                        width: 40,
                        child: Image.asset("assets/images/flag-rusia.webp"),
                      ),
                      SizedBox(width: 8),
                      CustomText(
                        text: "РУССКИЙ",
                        size: 16,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }

  void _openByMeCoffeURL() {
    final TranslationProvider provider =
        Provider.of<TranslationProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(provider.translationTextOf["support_thanks"]),
          backgroundColor: Colors.black,
          titleTextStyle: const TextStyle(color: Colors.amber),
          contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.amber, width: 1)),
          insetPadding: const EdgeInsets.all(24),
          contentPadding: const EdgeInsets.all(24),
          content: Text(provider.translationTextOf["support_content"]),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(provider.translationTextOf["support_cancel"]),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                final url = Uri.https('buymeacoffee.com', 'matias33pascual');
                launchUrl(url, mode: LaunchMode.externalApplication);
              },
              child: Text(provider.translationTextOf["support_continue"]),
            ),
          ],
        );
      },
    );
  }

  void _openDownloadURL() {
    final url = Uri.https(
        'github.com', 'matias33pascual/macros-to-helldivers-pc/releases');

    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _openUserManualURL() {
    String urlUserManual = "";

    final LanguagesEnum currentLanguage =
        TranslationState.instance.currentLanguage;

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
      default:
        urlUserManual = "view/manual-macros-en/página-principal";
        break;
    }

    final url = Uri.https(
      'sites.google.com',
      urlUserManual,
    );

    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _openVideoURL() {
    final url = Uri.https('youtu.be', 'ff934Jjuvdo');

    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        children: [
          _buildPanelTitle(),
          Container(
            margin: const EdgeInsets.only(top: 12),
            child: const CustomForm(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    final HomeProvider provider =
                        Provider.of<HomeProvider>(context, listen: false);

                    if (provider.state.port.isEmpty ||
                        provider.state.ipAddrress.isEmpty ||
                        provider.state.isLoading) {
                      return;
                    }

                    try {
                      ConnectionService.instance
                          .connectToServer(
                        provider.state.ipAddrress,
                        provider.state.port,
                        context,
                      )
                          .then(
                        (value) {
                          if (value) {
                            Navigator.pushNamed(
                                context, StratagemsPage.routeName);
                          } else {
                            if (kDebugMode) {
                              print(
                                  "No se pudo conectar al servidor: ConnectionService return false.");
                            }
                            provider.setMessageError(true);
                          }
                        },
                      ).onError(
                        (error, stackTrace) => throw Exception(error),
                      );
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
                    onTap: () => Navigator.of(context)
                        .pushNamed(StratagemsPage.routeName),
                    child: TestAppButton()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildPanelTitle() {
    final TranslationProvider provider =
        Provider.of<TranslationProvider>(context);

    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.amber[500]!.withOpacity(0.6),
            width: 2,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Container()),
            ],
          ),
          CustomText(
            text: provider.translationTextOf["input_hint"],
            size: 16,
            maxLines: 2,
            textColor: Colors.white,
            strokeColor: Colors.black.withOpacity(0.7),
            textAlign: TextAlign.center,
          ),
          CustomText(
            text: "MACROS TO HD2 Game PC",
            size: 16,
            maxLines: 2,
            textColor: Colors.amber,
            strokeColor: Colors.black.withOpacity(0.7),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _buildPanel() {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        border: Border.all(
          color: Colors.amber[500]!.withOpacity(0.6),
          width: 2,
          strokeAlign: StrokeAlign.inside,
        ),
      ),
    );
  }
}
