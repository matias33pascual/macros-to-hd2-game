import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/home_page/providers/exports_providers.dart';
import 'package:macros_to_helldivers/home_page/screens/home_page.dart';
import 'package:macros_to_helldivers/mission_page/providers/mission_provider.dart';
import 'package:macros_to_helldivers/mission_page/screens/mission_page.dart';
import 'package:macros_to_helldivers/shared/translation/translation_provider.dart';
import 'package:macros_to_helldivers/splash_page/splash_page.dart';
import 'package:macros_to_helldivers/stratagems_page/providers/exports_providers.dart';
import 'package:macros_to_helldivers/stratagems_page/screens/stratagems_page.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

const useDevMode = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await WakelockPlus.enable();

  ConnectButtonProvider connectButtonProvider = ConnectButtonProvider();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => connectButtonProvider),
        ChangeNotifierProvider(create: (_) => HomeProvider(connectButtonProvider: connectButtonProvider)),
        ChangeNotifierProvider(create: (_) => StratagemsProvider()),
        ChangeNotifierProvider(create: (_) => TabsMenuProvider()),
        ChangeNotifierProvider(create: (_) => SelectedProvider()),
        ChangeNotifierProvider(create: (_) => MissionProvider()),
        ChangeNotifierProvider(create: (_) => TranslationProvider()),
      ],
      child: useDevMode
          ? DevicePreview(
              enabled: useDevMode,
              tools: const [...DevicePreview.defaultTools],
              builder: (context) => const MyApp(),
            )
          : const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        StratagemsPage.routeName: (context) => const StratagemsPage(),
        MissionPage.routeName: (context) => const MissionPage(),
        SplashPage.routeName: (context) => const SplashPage(),
      },
      title: 'Macros to HD2 Game',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.routeName,
    );
  }
}
