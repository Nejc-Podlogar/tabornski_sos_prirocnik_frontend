
import 'package:flutter/material.dart';
import 'package:tabornski_sos_prirocnik_frontend/themes/default_dark.dart';

class checkmarkSwitch extends StatefulWidget {
  const checkmarkSwitch({super.key, required this.callback, required this.value});

  final Function callback;
  final bool value;

  @override
  _CheckMarkSwitchState createState() => _CheckMarkSwitchState();
}

class _CheckMarkSwitchState extends State<checkmarkSwitch> {

  final MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(
          Icons.check,
          color: Colors.white,
        );
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.value,
      onChanged: (value) {
        widget.callback(value);
      },
      activeTrackColor: Theme.of(context).primaryColor,
      activeColor: Colors.white,
      inactiveTrackColor: primaryCardTheme.color,
    );
  }
}