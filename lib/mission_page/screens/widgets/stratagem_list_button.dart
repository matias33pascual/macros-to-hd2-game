import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/shared/services/connection_service.dart';
import 'package:macros_to_helldivers/shared/translation/translation_provider.dart';
import 'package:macros_to_helldivers/shared/ui/custom_text.dart';
import 'package:macros_to_helldivers/stratagems_page/models/stratagems_model.dart';
import 'package:provider/provider.dart';

class StratagemListButton extends StatefulWidget {
  const StratagemListButton({
    Key? key,
    required this.stratagem,
  }) : super(key: key);

  final StratagemModel stratagem;

  @override
  State<StratagemListButton> createState() => _StratagemListButtonState();
}

class _StratagemListButtonState extends State<StratagemListButton> {
  bool isPressed = false;
  bool isCooldown = false;
  Timer? timer;
  double progress = 0;
  late double cooldownValue = widget.stratagem.cooldown;

  final ValueNotifier<double> valueNotifier = ValueNotifier(0);

  void _startCooldown() {
    isCooldown = true;

    if (timer != null) {
      timer!.cancel();
    }

    valueNotifier.value = 0;
    progress = valueNotifier.value;

    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      valueNotifier.value += 1;

      setState(() {
        progress = valueNotifier.value;
      });

      if (valueNotifier.value > cooldownValue - 1) {
        timer.cancel();

        isCooldown = false;
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TranslationProvider translationProvider =
        Provider.of<TranslationProvider>(context, listen: false);

    return GestureDetector(
      onTapDown: (details) => setState(() {
        isPressed = true;

        final message = {
          "type": "use-stratagem",
          "value": widget.stratagem.id,
        };

        final jsonMessage = jsonEncode(message);

        ConnectionService.instance.sendMessage(message: jsonMessage);

        _startCooldown();
      }),
      onTapUp: (details) => setState(() {
        isPressed = false;
      }),
      onTapCancel: () => setState(() {
        isPressed = false;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isPressed
              ? Colors.blue.withValues(alpha: 0.5)
              : Colors.blue[800]!.withValues(alpha: 0.4),
          border: Border.all(
            color: isPressed ? Colors.blue[400]! : Colors.blue.withValues(alpha: 0.7),
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
        child: Transform.scale(
          scale: isPressed ? 0.99 : 1,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: isCooldown ? 0.25 : 1,
                      child: Image.asset(
                        widget.stratagem.icon,
                        height: 80,
                      ),
                    ),
                    Opacity(
                      opacity: isCooldown ? 1 : 0,
                      child: ValueListenableBuilder<double>(
                        valueListenable: valueNotifier,
                        builder: (context, value, child) => Text(
                          (cooldownValue - value).toInt().toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            fontFamily: "helldivers",
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(3, 3),
                                blurRadius: 2,
                              ),
                              Shadow(
                                color: Colors.black,
                                offset: Offset(3, 3),
                                blurRadius: 4,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: CustomText(
                    textAlign: TextAlign.start,
                    text: translationProvider
                        .getTranslationOfStratagemName(widget.stratagem.id),
                    size: 17,
                    maxLines: 2,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
