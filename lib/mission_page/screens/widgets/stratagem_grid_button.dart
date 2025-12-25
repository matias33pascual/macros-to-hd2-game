import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/shared/services/connection_service.dart';
import 'package:macros_to_helldivers/stratagems_page/models/stratagems_model.dart';

class StratagemGridButton extends StatefulWidget {
  const StratagemGridButton({
    super.key,
    required this.stratagem,
  });

  final StratagemModel stratagem;

  @override
  State<StratagemGridButton> createState() => _StratagemGridButtonState();
}

class _StratagemGridButtonState extends State<StratagemGridButton> {
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
        margin: const EdgeInsets.all(3),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Transform.scale(
                scale: isPressed ? 0.98 : 1,
                child: Stack(
                  children: [
                    Center(
                      child: Opacity(
                        opacity: isCooldown ? 0.25 : 1,
                        child: Image.asset(
                          widget.stratagem.icon,
                        ),
                      ),
                    ),
                    Center(
                      child: Opacity(
                        opacity: isCooldown ? 1 : 0,
                        child: ValueListenableBuilder<double>(
                          valueListenable: valueNotifier,
                          builder: (context, value, child) => Text(
                            (cooldownValue - value).toInt().toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 60,
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
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
