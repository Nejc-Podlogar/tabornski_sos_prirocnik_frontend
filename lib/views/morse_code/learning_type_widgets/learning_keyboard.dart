import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/morse_exercise_bloc/morse_exercise_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/MorseCodeCustomDisplay.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/progress_dots.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/morse_code_language.dart';

class LearningKeyboard extends StatefulWidget {
  final MorseCodeLearningParams params;
  LearningKeyboard({super.key, required this.params});

  @override
  _LearningKeyboardState createState() => _LearningKeyboardState();
}

class _LearningKeyboardState extends State<LearningKeyboard> {
  TextEditingController textEditingController = TextEditingController();
  int index = 0;

  void displayBottomSheet(BuildContext context, AppLocalizations localizations,
      MorseExerciseState state, {bool finishExercise = false}) {
    if (finishExercise) {
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
    } else {
      // check if the exercise was completed successfully
      MorseCodeValidation lastValidation = state.correctAnswers!.last;
      Color currentColor = lastValidation == MorseCodeValidation.correct
          ? Theme.of(context).primaryColor
          : lastValidation == MorseCodeValidation.incorrect
              ? Theme.of(context).hintColor
              : lastValidation == MorseCodeValidation.partial
                  ? const Color(0xFFB2B39C)
                  : Colors.black;
      String text = lastValidation == MorseCodeValidation.correct
          ? localizations.correctAnswer
          : lastValidation == MorseCodeValidation.incorrect
              ? localizations.incorrectAnswer
              : lastValidation == MorseCodeValidation.partial
                  ? localizations.partiallyCorrectAnswer
                  : localizations.errorWhileValidating;

      Widget currentIcon = lastValidation == MorseCodeValidation.correct ?
        Icon(
          Icons.check_circle,
          color: currentColor,
          size: 32,
        ) : lastValidation == MorseCodeValidation.incorrect ?
        Icon(
          Icons.cancel,
          color: currentColor,
          size: 32,
        ) : lastValidation == MorseCodeValidation.partial ?
        Icon(
          Icons.help,
          color: currentColor,
          size: 32,
        ) : Icon(
          Icons.error,
          color: currentColor,
          size: 32,
        );


      showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          isDismissible: false,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      currentIcon,
                      const SizedBox(width: 10),
                      Text(
                        text,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: currentColor),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  lastValidation != MorseCodeValidation.correct ? Text('${localizations.correctAnswerWas}:') : const SizedBox(),
                  lastValidation != MorseCodeValidation.correct ? const SizedBox(height: 10) : const SizedBox(),
                  lastValidation != MorseCodeValidation.correct ? widget.params.learningType ==
                      MorseLanguageSetting.textToMorse
                      ? Expanded(
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            child: MorseCodeCustomDisplay(
                            morseCodeText: state.expectedAnswers![index], color: Colors.black),
                          ),
                        ),
                      )
                      : Text(state.expectedAnswers?[index] ??
                      'ERROR, NO EXERCISE') : const SizedBox(),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextButton(
                            onPressed: () {
                              if (state.exerciseText?.length == state.correctAnswers?.length) {
                                context.pop(context);
                                FocusScope.of(context).unfocus();
                                WidgetsBinding.instance.addPostFrameCallback((_) => displayBottomSheet(context, localizations, state, finishExercise: true));
                              } else {
                                BlocProvider.of<MorseExerciseBloc>(context)
                                    .add(MorseExerciseNext());
                                FocusScope.of(context).unfocus();
                                context.pop(context);
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: currentColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              localizations.nextExercise,
                              style: const TextStyle(color: Colors.white),
                            ))),
                  )
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return BlocConsumer<MorseExerciseBloc, MorseExerciseState>(
        listener: (BuildContext context, MorseExerciseState state) {
      if (state is MorseExerciseNextE) {
        if (index < (state.exerciseText?.length ?? 0) - 1) {
          setState(() {
            index++;
            textEditingController.clear();
          });
        }
      } else if (state is MorseExerciseValidated) {
        displayBottomSheet(context, localizations, state);
      }
    }, builder: (BuildContext context, MorseExerciseState state) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                localizations.translateTheFollowingText,
                softWrap: true,
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.info_outline_rounded),
                  const SizedBox(width: 10),
                  Text(localizations.translateTheFollowingTextDescription),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child:
                          Icon(Icons.fitness_center_rounded, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Text(
                      state.exerciseText?[index] ?? 'ERROR, NO EXERCISE',
                      softWrap: true,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff656839).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(25),
                      border:
                          Border.all(color: const Color(0xFFB2B39C), width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 2.0),
                      child: TextField(
                        maxLines: 10,
                        controller: textEditingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '${localizations.enterTranslation}...',
                          hintStyle: const TextStyle(
                            color: Color(0xFF656839),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text('${localizations.progress}:'),
                ),
              ),
              Center(
                child: ProgressDots(
                    correctAnswers: state.correctAnswers ?? [],
                    exerciseSize: state.exerciseText?.length ?? 0),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    BlocProvider.of<MorseExerciseBloc>(context).add(
                        MorseExerciseValidate(
                            null,
                            interactionType: LearningInteractionType.keyboard,
                            indexOfValueToCompare: index,
                            userInput: textEditingController.text,
                            translationType: widget.params.learningType,
                            valueAmount: widget.params.learningAmount,
                        ));
                  },
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Center(
                        child: Text(
                          localizations.check,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
