import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/mission_page/providers/mission_provider.dart';
import 'package:macros_to_helldivers/mission_page/screens/widgets/exports_widgets.dart';
import 'package:macros_to_helldivers/shared/translation/translation_provider.dart';
import 'package:macros_to_helldivers/shared/ui/exports_shared.dart';
import 'package:macros_to_helldivers/stratagems_page/providers/exports_providers.dart';
import 'package:provider/provider.dart';

class MissionPage extends StatelessWidget {
  const MissionPage({Key? key}) : super(key: key);

  static String routeName = "mission_page";

  @override
  Widget build(BuildContext context) {
    final MissionProvider provider = Provider.of<MissionProvider>(context);

    final StratagemsProvider stratagemsProvider =
        Provider.of<StratagemsProvider>(context, listen: false);

    final TranslationProvider translationProvider =
        Provider.of<TranslationProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: translationProvider.translationTextOf["mission"].toUpperCase(),
          color: Colors.blue[900]!.withValues(alpha: 0.2),
          actionButton:
              stratagemsProvider.state.stratagemsSelectedForMission.length > 2
                  ? _buildActionButton(provider)
                  : null,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            _buildBackground(context),
            _buildPanel(context),
            const MissionStratagems(),
          ],
        ),
      ),
    );
  }

  Container _buildPanel(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withValues(alpha: 0.4),
    );
  }

  Image _buildBackground(BuildContext context) {
    return Image.asset(
      "assets/images/mission_background.webp",
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      color: Colors.indigo[500],
      colorBlendMode: BlendMode.color,
    );
  }

  _buildActionButton(MissionProvider provider) {
    return GestureDetector(
      onTap: () => provider.setNewLayout(),
      child: Container(
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.only(right: 10, top: 7, bottom: 7),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.indigo[700]!,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Image.asset(
          provider.getIconPath(),
          color: Colors.indigo[700]!.withValues(alpha: 0.4),
          colorBlendMode: BlendMode.color,
        ),
      ),
    );
  }
}
