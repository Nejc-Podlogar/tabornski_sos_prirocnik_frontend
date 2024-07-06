


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../blocs/morse_exercise_bloc/morse_exercise_bloc.dart';
import '../../../models/morse_code_language.dart';
import '../../../widgets/MorseCodeCustomDisplay.dart';
import '../../../widgets/progress_dots.dart';

class LearningCards extends StatelessWidget {
  final MorseCodeLearningParams params;
  LearningCards({required this.params});

  final CardSwiperController cardSwiperController = CardSwiperController();

  bool isMorseCode(String text) {
    return RegExp(r'^[\.\- \/]+$').hasMatch(text);
  }

  void displayBottomSheet(BuildContext context, AppLocalizations localizations, MorseExerciseState state) {

    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(25)),
        ),
        isDismissible: false,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  localizations.endOfExercise,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 20),
                ProgressDots(
                    correctAnswers: state.correctAnswers ?? [],
                    exerciseSize: state.exerciseText?.length ?? 0),
                const SizedBox(height: 20),
                SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextButton(
                        onPressed: () {
                          BlocProvider.of<MorseExerciseBloc>(context)
                              .add(MorseExerciseNext());
                          context.pop(context);
                          context.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          localizations.finishExercise,
                          style: const TextStyle(color: Colors.white),
                        )))
              ],
            ),
          );
        });

  }



  List<Widget> createCards(BuildContext context, List<String> valueText,
      List<String> translatedText) {
    List<Widget> cards = [];

    for (int i = 0; i < valueText.length; i++) {
      bool inputIsMorseCode = isMorseCode(valueText[i]);
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
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: (params.learningAmount == MorseCodeLearningAmount.sentences && params.learningType == MorseLanguageSetting.textToMorse) ? 100 : MediaQuery.of(context).size.height * 0.25,
                          maxHeight: MediaQuery.of(context).size.height * 0.35,
                        ),
                        child: IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: inputIsMorseCode ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RawScrollbar(
                                    thumbVisibility: true,
                                    radius: const Radius.circular(10),
                                    thumbColor: Colors.white,
                                    controller: ScrollController(),
                                    thickness: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SingleChildScrollView(
                                        child: MorseCodeCustomDisplay(
                                          morseCodeText: valueText[i],
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ) : Text(
                                  valueText[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: params.learningAmount == MorseCodeLearningAmount.sentences ? 18 : 30,
                                      fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                      child: Center(
                          child: inputIsMorseCode ?
                          Text(
                            translatedText[i],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: params.learningAmount == MorseCodeLearningAmount.sentences ? 18 : 30 ,
                                fontWeight: FontWeight.bold),
                          ) :
                          Scrollbar(
                            thumbVisibility: true,
                            radius: const Radius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                child: MorseCodeCustomDisplay(
                                  morseCodeText: translatedText[i],
                                  color: Colors.black,
                                ),
                              ),
                            ),
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
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return BlocBuilder<MorseExerciseBloc, MorseExerciseState>(
      buildWhen: (previous, current) {
        if (current is MorseExerciseStart) {
          return true;
        }
        return false;

      },
        builder: (BuildContext context, MorseExerciseState state) {
            final valueText = state.exerciseText;
            final translatedText = state.expectedAnswers;

            final cards = createCards(context, valueText!, translatedText!);

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
                          numberOfCardsDisplayed: valueText.length == 1 ? 1 : 2,
                          controller: cardSwiperController,
                          allowedSwipeDirection:
                          const AllowedSwipeDirection.only(left: true, right: true),
                          cardBuilder:
                              (context, index, percentThresholdX, percentThresholdY) =>
                          cards[index],
                          onSwipe: (previousIndex, index, swipeDirection) {
                            if (swipeDirection == CardSwiperDirection.right) {
                              BlocProvider.of<MorseExerciseBloc>(context).add(MorseExerciseValidate(
                                  CardSwiperDirection.right,
                                  interactionType: LearningInteractionType.cards,
                                  userInput: valueText  [previousIndex],
                                  indexOfValueToCompare: previousIndex,
                                  translationType: MorseLanguageSetting.textToMorse,
                                  valueAmount: MorseCodeLearningAmount.words));
                              return true;
                            } else if (swipeDirection == CardSwiperDirection.left) {
                              BlocProvider.of<MorseExerciseBloc>(context).add(MorseExerciseValidate(
                                  CardSwiperDirection.left,
                                  interactionType: LearningInteractionType.cards,
                                  userInput: valueText[previousIndex],
                                  indexOfValueToCompare: previousIndex,
                                  translationType: MorseLanguageSetting.textToMorse,
                                  valueAmount: MorseCodeLearningAmount.words));
                              return true;


                            }
                            return false;
                          },
                          onEnd: () {

                            // get the bloc state
                            final stateCurrent = BlocProvider.of<MorseExerciseBloc>(context).state;

                            displayBottomSheet(context, localizations, stateCurrent);

                          },
                          onUndo: (previousIndex, index, direction) {
                            BlocProvider.of<MorseExerciseBloc>(context).add(UndoPreviousAnswer());
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
                  bloc: BlocProvider.of<MorseExerciseBloc>(context),
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: ProgressDots(correctAnswers: state.correctAnswers ??  [], exerciseSize: valueText.length),
                    );
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


    );
  }

}