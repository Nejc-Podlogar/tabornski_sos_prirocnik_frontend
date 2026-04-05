import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/api/morse_exercise_api_service.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/morse_exercise_bloc/morse_exercise_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/routing/route_definitions.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/morse_code_language.dart';
import '../../widgets/navigation_bottom.dart';

class MorseCodeLearning extends StatefulWidget {
  const MorseCodeLearning({Key? key}) : super(key: key);

  @override
  _MorseCodeLearningState createState() => _MorseCodeLearningState();
}

class _MorseCodeLearningState extends State<MorseCodeLearning> {
  MorseLanguageSetting? _selectedLearningType;
  MorseCodeLearningAmount? _selectedLearningAmount;
  LearningInteractionType? _selectedLearningInteractionType;
  int? _selectedNumberOfRepetitions;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _resetState());
    super.initState();
  }

  void _resetState() {
    setState(() {
      _selectedLearningType = null;
      _selectedLearningAmount = null;
      _selectedLearningInteractionType = null;
      _selectedNumberOfRepetitions = null;
    });
  }



  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Morse Code Learning', enablePopButton: true),
      bottomNavigationBar: CustomBottomNavigation(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              /*const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Morse Code Learning'),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'From the option below, select the desired learning case for morse code.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'JetBrains Mono',
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                indent: 20,
                endIndent: 20,
                thickness: 1,
                color: Colors.black,
              ),*/
              const SizedBox(height: 10),
              Center(
                child: Text('${localization.learningType}:'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ChoiceChip(
                    backgroundColor: Theme.of(context).chipTheme.backgroundColor,
                    showCheckmark: false,
                    label: SizedBox(
                        width: 90,
                        height: 16,
                        child: Center(child: Text(localization.transmitting))),
                    selected:
                        _selectedLearningType == MorseLanguageSetting.textToMorse,
                    labelStyle: TextStyle(
                      color: _selectedLearningType ==
                              MorseLanguageSetting.textToMorse
                          ? Colors.white
                          : Theme.of(context).chipTheme.labelStyle!.color,
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedLearningType =
                            selected ? MorseLanguageSetting.textToMorse : null;
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  ChoiceChip(
                    showCheckmark: false,
                    label: SizedBox(
                        width: 90,
                        height: 16,
                        child: Center(child: Text(localization.receiving))),
                    selected:
                        _selectedLearningType == MorseLanguageSetting.morseToText,
                    labelStyle: TextStyle(
                      color: _selectedLearningType ==
                              MorseLanguageSetting.morseToText
                          ? Colors.white
                          : Theme.of(context).chipTheme.labelStyle!.color,
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedLearningType =
                            selected ? MorseLanguageSetting.morseToText : null;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Text('${localization.sizeOfQuestion}:'),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 20,
                  runSpacing: 1,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    ChoiceChip(
                      showCheckmark: false,
                      label: SizedBox(
                          width: 90,
                          height: 16,
                          child: Center(child: Text(localization.letters))),
                      selected: _selectedLearningAmount ==
                          MorseCodeLearningAmount.letters,
                      labelStyle: TextStyle(
                        color: _selectedLearningAmount ==
                                MorseCodeLearningAmount.letters
                            ? Colors.white
                            : Theme.of(context).chipTheme.labelStyle!.color,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedLearningAmount =
                              selected ? MorseCodeLearningAmount.letters : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      showCheckmark: false,
                      label: SizedBox(
                          width: 90,
                          height: 16,
                          child: Center(child: Text(localization.words))),
                      selected: _selectedLearningAmount ==
                          MorseCodeLearningAmount.words,
                      labelStyle: TextStyle(
                        color: _selectedLearningAmount ==
                                MorseCodeLearningAmount.words
                            ? Colors.white
                            : Theme.of(context).chipTheme.labelStyle!.color,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedLearningAmount =
                              selected ? MorseCodeLearningAmount.words : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      showCheckmark: false,
                      label: SizedBox(
                          width: 90,
                          height: 16,
                          child: Center(child: Text(localization.sentences))),
                      selected: _selectedLearningAmount ==
                          MorseCodeLearningAmount.sentences,
                      labelStyle: TextStyle(
                        color: _selectedLearningAmount ==
                            MorseCodeLearningAmount.sentences
                            ? Colors.white
                            : Theme.of(context).chipTheme.labelStyle!.color,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedLearningAmount =
                          selected ? MorseCodeLearningAmount.sentences : null;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text('${localization.userInterface}:'),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 20,
                  runSpacing: 1,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    ChoiceChip(
                      label: SizedBox(
                          width: 51,
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/icons/card_swipe_icon.svg',
                                height: 60,
                                width: 80,
                              ),
                              Text(localization.cardSwipe),
                            ],
                          )),
                      showCheckmark: false,
                      selected: _selectedLearningInteractionType ==
                          LearningInteractionType.cards,
                      labelStyle: TextStyle(
                        color: _selectedLearningInteractionType ==
                            LearningInteractionType.cards
                            ? Colors.white
                            : Theme.of(context).chipTheme.labelStyle!.color,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedLearningInteractionType =
                          selected ? LearningInteractionType.cards : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      label: SizedBox(
                          width: 51,
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.keyboard_outlined, size: 30, color: _selectedLearningInteractionType ==
                                  LearningInteractionType.keyboard
                                  ? Colors.white
                                  : Theme.of(context).chipTheme.labelStyle!.color,),
                              Text(localization.keyboard, style: const TextStyle(
                                fontSize: 12
                              ),),
                            ],
                          )),
                      showCheckmark: false,
                      selected: _selectedLearningInteractionType ==
                          LearningInteractionType.keyboard,
                      labelStyle: TextStyle(
                        color: _selectedLearningInteractionType ==
                            LearningInteractionType.keyboard
                            ? Colors.white
                            : Theme.of(context).chipTheme.labelStyle!.color,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedLearningInteractionType =
                          selected ? LearningInteractionType.keyboard : null;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text('${localization.amountOfRepetitions}:'),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 20,
                  runSpacing: 1,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    ChoiceChip(
                      showCheckmark: false,
                      label: const SizedBox(
                          width: 26,
                          height: 16,
                          child: Center(child: Text('1'))),
                      selected: _selectedNumberOfRepetitions ==
                          1,
                      labelStyle: TextStyle(
                        color: _selectedNumberOfRepetitions ==
                            1
                            ? Colors.white
                            : Theme.of(context).chipTheme.labelStyle!.color,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedNumberOfRepetitions =
                          selected ? 1 : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      showCheckmark: false,
                      label: const SizedBox(
                          width: 26,
                          height: 16,
                          child: Center(child: Text('5'))),
                      selected: _selectedNumberOfRepetitions ==
                          5,
                      labelStyle: TextStyle(
                        color: _selectedNumberOfRepetitions ==
                            5
                            ? Colors.white
                            : Theme.of(context).chipTheme.labelStyle!.color,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedNumberOfRepetitions =
                          selected ? 5 : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      showCheckmark: false,
                      label: const SizedBox(
                          width: 26,
                          height: 16,
                          child: Center(child: Text('10'))),
                      selected: _selectedNumberOfRepetitions ==
                          10,
                      labelStyle: TextStyle(
                        color: _selectedNumberOfRepetitions ==
                            10
                            ? Colors.white
                            : Theme.of(context).chipTheme.labelStyle!.color,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedNumberOfRepetitions =
                          selected ? 10 : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      showCheckmark: false,
                      label: const SizedBox(
                          width: 26,
                          height: 16,
                          child: Center(child: Text('20'))),
                      selected: _selectedNumberOfRepetitions ==
                          20,
                      labelStyle: TextStyle(
                        color: _selectedNumberOfRepetitions ==
                            20
                            ? Colors.white
                            : Theme.of(context).chipTheme.labelStyle!.color,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedNumberOfRepetitions =
                          selected ? 20 : null;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              TextButton(
                  onPressed: () async {
                    MorseCodeLanguage response = await MorseExerciseApiService().getSpecificExercise(MorseCodeLearningParams(
                      learningType: _selectedLearningType!,
                      learningAmount: _selectedLearningAmount!,
                      learningInteractionType: _selectedLearningInteractionType!,
                      numberOfIterations: _selectedNumberOfRepetitions!,
                    ));

                    BlocProvider.of<MorseExerciseBloc>(context).add(MorseExerciseStart(exerciseText: response.value!, expectedAnswers: response.translatedValue!, response.areTranslationsCorrect));

                    context.pushNamed(RouteNames.morseCodeLearning, extra: {'params': MorseCodeLearningParams(
                    learningType: _selectedLearningType!,
                    learningAmount: _selectedLearningAmount!,
                    learningInteractionType: _selectedLearningInteractionType!,
                    numberOfIterations: _selectedNumberOfRepetitions!,
                  )});

                  },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.85, 50),
                ),
                  child: Text(localization.beginLearning),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
