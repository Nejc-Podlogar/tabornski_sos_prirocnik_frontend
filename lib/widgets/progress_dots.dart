import 'package:flutter/material.dart';
import '../models/morse_code_language.dart'; // Assuming MorseCodeValidation is defined here

class ProgressDots extends StatelessWidget {
  final List<dynamic> correctAnswers; // Changed to List<dynamic>
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
            var answer = correctAnswers[index];
            if (answer is MorseCodeValidation) {
              // Handle MorseCodeValidation
              switch (answer) {
                case MorseCodeValidation.correct:
                  dotColor = Theme.of(context).primaryColor;
                  iconData = Icons.check;
                  break;
                case MorseCodeValidation.partial:
                  dotColor = Colors.grey;
                  iconData = Icons.question_mark_sharp;
                  break;
                default:
                  dotColor = Theme.of(context).hintColor;
                  iconData = Icons.close;
              }
            } else if (answer is bool) {
              // Handle bool
              if (answer) {
                dotColor = Theme.of(context).primaryColor;
                iconData = Icons.check;
              } else {
                dotColor = Theme.of(context).hintColor;
                iconData = Icons.close;
              }
            } else {
              // Default case if neither MorseCodeValidation nor bool
              dotColor = Colors.transparent;
              iconData = Icons.circle;
            }
            decoration = BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
              border: answer == true || answer is MorseCodeValidation && answer != MorseCodeValidation.correct ? null : Border.all(color: Colors.grey, width: 1),
            );
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