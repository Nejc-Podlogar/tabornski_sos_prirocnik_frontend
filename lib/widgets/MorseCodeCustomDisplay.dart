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
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 2.0, // Space between the dots and dashes horizontally
      runSpacing: 4.0, // Space between the lines vertically
      children: morseCodeText.split('').map((e) {
        return e == '.'
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: color,
                ),
              )
            : e == '-'
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        width: 25, // Same as the diameter of the CircleAvatar
                        height: 6, // Specify the height of the dash
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: color,
                        )),
                  )
                : const SizedBox(width: 20,); // Use SizedBox.shrink() for an empty space that takes no space
      }).toList(),
    );
  }
}
