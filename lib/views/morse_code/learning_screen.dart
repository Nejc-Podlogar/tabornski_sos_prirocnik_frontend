import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/morse_exercise_bloc/morse_exercise_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/views/morse_code/learning_type_widgets/learning_cards.dart';
import 'package:tabornski_sos_prirocnik_frontend/views/morse_code/learning_type_widgets/learning_keyboard.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/MorseCodeCustomDisplay.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/navigation_bottom.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/progress_dots.dart';

import '../../models/morse_code_language.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({Key? key, required this.params}) : super(key: key);

  final MorseCodeLearningParams params;

  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final MorseExerciseBloc morseExerciseBloc = MorseExerciseBloc();

  // Arrays for card testing
  List<String> valueText = ['ena', 'dve', 'tri', 'stiri'];
  List<String> translatedText = [
    '. -. .-',
    '-.. ...- .',
    '- .-. ..',
    '... - .. .-. ..'
  ];
  List<String> answers = [
    '. -. .-',
    '. -. .-',
    '- .-. ....',
    '... - .. .-. ..'
  ];

  @override
  void initState() {
    morseExerciseBloc.add(MorseExerciseStart(
        exerciseText: valueText, expectedAnswers: translatedText));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Morse Code Learning',
        enablePopButton: true,
      ),
      bottomNavigationBar: CustomBottomNavigation(),
      body: widget.params.interactionType == LearningInteractionType.cards ? LearningCards(answers: answers, morseExerciseBloc: morseExerciseBloc, translatedText: translatedText, valueText: valueText) : widget.params.interactionType == LearningInteractionType.keyboard ? LearningKeyboard(params: widget.params,) : const SizedBox(),
    );
  }
}
