// Create a function that would build a display element based on the morse code text. With circles and dashes all aligned in the middle

import 'package:flutter/material.dart';

class MorseCodeCustomDisplay extends StatelessWidget {
  final String morseCodeText;
  final Color color;

  const MorseCodeCustomDisplay(
      {Key? key, required this.morseCodeText, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> displayElements = [];
    for (int i = 0; i < morseCodeText.length; i++) {
      String e = morseCodeText[i];
      if (e == '.') {
        displayElements.add(Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 5,
            backgroundColor: color,
          ),
        ));
      } else if (e == '-') {
        displayElements.add(Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 25,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: color,
            ),
          ),
        ));
      } else if (e == ' ') {
        displayElements.add(Transform.rotate(
          angle: 40 * 3.14 / 180,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: color,
              ),
              width: 2,
              height: 20,
            ),
          ),
        ));
      }
      if (i < morseCodeText.length - 1 &&
          morseCodeText[i + 1] != ' ' &&
          e != ' ') {
        displayElements.add(const SizedBox.shrink());
      }
    }

    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      spacing: 2.0,
      runSpacing: 4.0,
      children: displayElements,
    );
  }
}
