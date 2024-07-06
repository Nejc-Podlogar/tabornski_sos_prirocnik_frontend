
// crate a widget that would display a number of circles with different colors.
// the input would be an array with values of type MorseCodeValidation. If the entry is correct, the circle is green, otherwise red. if it is partially, make it yellow.
// it needs to be a row of the dots, centered in the middle of the screen.

import 'package:flutter/material.dart';

import '../models/morse_code_language.dart';

class ProgressDots extends StatelessWidget {
  final List<MorseCodeValidation> correctAnswers;
  final int exerciseSize;

  ProgressDots({required this.correctAnswers, required this.exerciseSize});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      spacing: 6,
      runSpacing: 5,
      children: List.generate(
        exerciseSize,
        (index) {
          Color dotColor;
          IconData iconData;
          BoxDecoration decoration;
          if (index < correctAnswers.length) {
            switch (correctAnswers[index]) {
              case MorseCodeValidation.correct:
                dotColor = Theme.of(context).primaryColor;
                iconData = Icons.check;
                decoration = BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                );
                break;
              case MorseCodeValidation.partial:
                dotColor = Colors.grey;
                iconData = Icons.question_mark_sharp;
                decoration = BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                );
                break;
              default:
                dotColor = Theme.of(context).hintColor;
                iconData = Icons.close;
                decoration = BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                );
            }
          } else {
            dotColor = Colors.transparent;
            iconData = Icons.circle;
            decoration = BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 1),
            );
          }

          return Container(
            width: 15,
            height: 15,
            decoration: decoration,
            child: Icon(
              iconData,
              color: Colors.white,
              size: 10,
            ),
          );
        },
      ),
    );
  }
}