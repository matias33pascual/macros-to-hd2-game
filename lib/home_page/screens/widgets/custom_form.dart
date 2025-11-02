import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/home_page/providers/exports_providers.dart';
import 'package:macros_to_helldivers/shared/ui/exports_shared.dart';
import 'package:provider/provider.dart';

import '../../../shared/translation/translation_provider.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKeyIp = GlobalKey<FormState>();
    final formKeyPort = GlobalKey<FormState>();

    final HomeProvider provider = Provider.of<HomeProvider>(context);
    final TranslationProvider translationProvider = Provider.of<TranslationProvider>(context);

    return Column(
      children: [
        CustomInputField(
          hintText: provider.state.ipAddrress.isEmpty
              ? translationProvider.translationTextOf["ip_address"]
              : provider.state.ipAddrress,
          formKey: formKeyIp,
          onChangedHandle: (String value) => provider.setIPAddress(value),
        ),
        const SizedBox(height: 6),
        CustomInputField(
          hintText: provider.state.port.isEmpty ? translationProvider.translationTextOf["port"] : provider.state.port,
          textInputType: TextInputType.number,
          formKey: formKeyPort,
          onChangedHandle: (String value) => provider.setPort(value),
        ),
        if (provider.state.isLoading) _buildLoadingWidget(context),
        if (!provider.state.isLoading) const SizedBox(height: 9),
      ],
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 6.0),
      child: LinearProgressIndicator(
        backgroundColor: Colors.white,
        color: Colors.amber,
      ),
    );
  }
}
