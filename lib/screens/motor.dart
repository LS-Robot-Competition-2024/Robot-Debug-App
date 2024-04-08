////////////////////////////////////////////////////////////////////////////////////////////
/// import
////////////////////////////////////////////////////////////////////////////////////////////

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:robo_debug_app/components/snackbar.dart';
import 'package:robo_debug_app/components/style.dart';
import 'package:robo_debug_app/main.dart';
import 'package:robo_debug_app/providers/websocket_provider.dart';

// 未実装
class MotorScreen extends ConsumerStatefulWidget {
  const MotorScreen({super.key});

  @override
  ConsumerState<MotorScreen> createState() => MotorScreenState();
}

class MotorScreenState extends ConsumerState<MotorScreen> {
  
  @override
  Widget build(BuildContext context) {


    double kp = ref.watch(settingProvider).kp;
    double ki = ref.watch(settingProvider).ki;
    double kd = ref.watch(settingProvider).kd;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('PID Tuning', style: Styles.defaultStyle18),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Kp -> Ki -> Kd の順番で調整してください',
                  style: Styles.defaultStyle18,
                ),
                Text(
                  'Kp: ${kp.round()}',
                  style: Styles.defaultStyle18,
                ),
                Slider(
                  value: kp,
                  activeColor: Styles.primaryColor,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: kd.round().toString(),
                  onChanged: (value) => {},
                  onChangeEnd: (double value) {
                    setState(() {
                      updatePidValue('kp', value);
                    });
                  },
                ),
                Text(
                  'Ki: ${ki.round()}',
                  style: Styles.defaultStyle18,
                ),
                Slider(
                  value: ki,
                  activeColor: Styles.primaryColor,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: ki.round().toString(),
                  onChanged: (value) => {},
                  onChangeEnd: (double value) {
                    setState(() {
                      updatePidValue('ki', value);
                    });
                  },
                ),
                Text(
                  'Kd: ${kd.round()}',
                  style: Styles.defaultStyle18,
                ),
                Slider(
                  value: kd,
                  activeColor: Styles.primaryColor,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: kd.round().toString(),
                  onChanged: (value) => {},
                  onChangeEnd: (double value) {
                    setState(() {
                      updatePidValue('kd', value);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updatePidValue(String type, double value) {
    final status = ref.read(webSocketProvider).status;

    if (status == ConnectionStatusType.connected) {
      switch (type) {
        case 'kp':
          ref.read(settingProvider).kp = value;
          break;
        case 'ki':
          ref.read(settingProvider).ki = value;
          break;
        case 'kd':
          ref.read(settingProvider).kd = value;
          break;
      }
      ref.read(settingProvider).storePreferences();

      final String message = 'PID:$type:$value';
      ref.read(webSocketProvider.notifier).sendMessage(message);

    } else {
      showSnackBar(
        message: "WebSocket is not connected",
        type: SnackBarType.error,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
