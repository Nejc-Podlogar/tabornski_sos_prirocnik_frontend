


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../../blocs/morse_exercise_bloc/morse_exercise_bloc.dart';
import '../../../models/morse_code_language.dart';
import '../../../widgets/MorseCodeCustomDisplay.dart';
import '../../../widgets/progress_dots.dart';

class LearningCards extends StatelessWidget {
  final MorseExerciseBloc morseExerciseBloc;
  final List<String> valueText;
  final List<String> translatedText;
  final List<String> answers;

  LearningCards({required this.morseExerciseBloc, required this.valueText, required this.translatedText, required this.answers});

  final CardSwiperController cardSwiperController = CardSwiperController();



  List<Widget> createCards(BuildContext context, List<String> valueText,
      List<String> translatedText) {
    List<Widget> cards = [];

    for (int i = 0; i < valueText.length; i++) {
      cards.add(
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                border: Border.all(color: const Color(0x00000025), width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFB2B39C),
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context).primaryColor,
                        ),
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Center(
                          child: Text(
                            valueText[i],
                            style: const TextStyle(
                                fontSize: 100, color: Colors.white),
                          ),
                        ),
                      )),
                  Expanded(
                      child: Center(
                          child: MorseCodeCustomDisplay(
                            morseCodeText: translatedText[i],
                            color: Colors.black,
                          ))),
                ],
              ),
            )),
      );
    }

    return cards;
  }


  @override
  Widget build(BuildContext context) {
    final cards = createCards(context, valueText, translatedText);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width * 0.9,
              child: CardSwiper(
                  cardsCount: cards.length,
                  initialIndex: 0,
                  isLoop: false,
                  controller: cardSwiperController,
                  allowedSwipeDirection:
                  const AllowedSwipeDirection.only(left: true, right: true),
                  cardBuilder:
                      (context, index, percentThresholdX, percentThresholdY) =>
                  cards[index],
                  onSwipe: (previousIndex, index, swipeDirection) {
                    if (swipeDirection == CardSwiperDirection.right) {
                      morseExerciseBloc.add(MorseExerciseValidate(
                          userInput: answers[previousIndex],
                          indexOfValueToCompare: previousIndex,
                          translationType: MorseLanguageSetting.textToMorse,
                          valueAmount: MorseCodeLearningAmount.words));
                      return true;
                    }
                    return false;
                  },
                  onEnd: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('FINISHED'),
                          content: Text('Finished the exercise'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );

                  },
                  onUndo: (previousIndex, index, direction) {
                    morseExerciseBloc.add(UndoPreviousAnswer());
                    return true;
                  }
              )),
        ),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text(
                'Progress:'
            ),
          ),
        ),
        BlocBuilder<MorseExerciseBloc, MorseExerciseState>(
          bloc: morseExerciseBloc,
          builder: (context, state) {
            return ProgressDots(correctAnswers: state.correctAnswers ??  [], exerciseSize: valueText.length);
          },
        ),
        Expanded(
          child: Center(
            child: Wrap(
              spacing: 25.0,
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                          style: BorderStyle.solid,
                          width: 3,
                          color: Theme.of(context).primaryColor)),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.close_rounded,
                          color: Theme.of(context).primaryColor, size: 50),
                      onPressed: () => cardSwiperController
                          .swipe(CardSwiperDirection.left),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0x4D656839),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.rotate_left_rounded,
                          color: Colors.white, size: 24),
                      onPressed: () => cardSwiperController.undo(),
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.check_rounded,
                          color: Colors.white, size: 50),
                      onPressed: () => cardSwiperController
                          .swipe(CardSwiperDirection.right),
                    ),
                  ),
                ),
                /*TextButton(
                    onPressed: cardSwiperController.undo,
                    child: const Icon(Icons.rotate_left),
                  ),*/
              ],
            ),
          ),
        )
      ],
    );
  }

}