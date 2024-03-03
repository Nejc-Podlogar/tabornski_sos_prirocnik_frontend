// Create a function that would build a display element based on the morse code text. With circles and dashes all aligned in the middle

import 'package:flutter/material.dart';

class MorseCodeCustomDisplay extends StatelessWidget {
  final String morseCodeText;
  final Color color;

  const MorseCodeCustomDisplay({Key? key, required this.morseCodeText, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: morseCodeText.split('').map((e) {
        return e == '.' ? Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 5,
            backgroundColor: color,
          ),
        ) : e == '-' ? Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 15, // Same as the diameter of the CircleAvatar
            height: 4, // Specify the height of the dash
            color: color,
          ),
        ) : const SizedBox();
      }).toList(),
    );
  }
}