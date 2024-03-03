import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/navigation_bottom.dart';

import '../../blocs/morse_translation_bloc/morse_translation_bloc.dart';
import '../../models/morse_code_language.dart';
import '../../themes/default_dark.dart';

class MorseCodeTranslatorView extends StatefulWidget {
  const MorseCodeTranslatorView({Key? key}) : super(key: key);

  @override
  _MorseCodeTranslatorViewState createState() =>
      _MorseCodeTranslatorViewState();
}

class _MorseCodeTranslatorViewState extends State<MorseCodeTranslatorView> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textTranslatedController =
      TextEditingController();

  // Handle input translation
  void _handleInputTranslation(String input) {
    final morseTranslationBloc = BlocProvider.of<MorseTranslationBloc>(context);
    // add morseCodeLanguageModel from the current state and the input wit TranslateInput event
    morseTranslationBloc.add(TranslateInput(
        inputText: input,
        morseCodeLanguageModel:
            (morseTranslationBloc.state as MorseTranslationInitial)
                .languageSetting));
  }

  Row _buildButtonsRow(BuildContext context, dynamic leftButtonContent,
      dynamic rightButtonContent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildLanguageButton(context, leftButtonContent,
            isOnlyButton: rightButtonContent == null),
        if (rightButtonContent != null) ...[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward,
              size: 40,
              color: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
          ),
          _buildLanguageButton(context, rightButtonContent),
        ]
      ],
    );
  }

  SizedBox _buildLanguageButton(BuildContext context, dynamic content,
      {bool isOnlyButton = false}) {
    return SizedBox(
      width: isOnlyButton
          ? MediaQuery.of(context).size.width * 0.5
          : MediaQuery.of(context).size.width * 0.3,
      height: 60,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).hintColor,
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () => _showtranslationTypeBottomSheet(context),
          child: content.endsWith('.svg')
              ? SvgPicture.asset(
                  content,
                  fit: BoxFit.contain,
                )
              : Text(
                  content,
                  textAlign: TextAlign.center,
                )),
    );
  }

  void _showtranslationTypeBottomSheet(BuildContext context) {
    final morseTranslationBloc = BlocProvider.of<MorseTranslationBloc>(context);
    final currentTranslationType =
        (morseTranslationBloc.state as MorseTranslationInitial)
            .languageSetting
            .languageSetting;

    showModalBottomSheet(
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildListTile(
                    context,
                    'Besedilo v Morsejevo abecedo',
                    MorseLanguageSetting.textToMorse,
                    currentTranslationType,
                    morseTranslationBloc),
                _buildListTile(
                    context,
                    'Morsejeva abeceda v besedilo',
                    MorseLanguageSetting.morseToText,
                    currentTranslationType,
                    morseTranslationBloc),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  Widget _buildListTile(
      BuildContext context,
      String title,
      MorseLanguageSetting setting,
      MorseLanguageSetting currentTranslationType,
      MorseTranslationBloc morseTranslationBloc) {
    return Container(
      decoration: BoxDecoration(
        color: currentTranslationType == setting
            ? Theme.of(context).hintColor
            : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                color: currentTranslationType != setting
                    ? Colors.black
                    : Colors.white)),
        trailing: currentTranslationType == setting
            ? const Icon(Icons.check, color: Colors.white)
            : null,
        onTap: () {
          morseTranslationBloc
              .add(UpdateTranslationType(morseCodeLanguageType: setting));
          context.pop();
        },
      ),
    );
  }

  //The custom bottom sheet for the settings.
  void showTorchSettingsBottomSheet(BuildContext context) {
  final morseTranslationBloc = BlocProvider.of<MorseTranslationBloc>(context);

  showModalBottomSheet(
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        )),
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<MorseTranslationBloc, MorseTranslationState>(
          bloc: morseTranslationBloc,
          builder: (BuildContext context, MorseTranslationState state) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SwitchListTile(
                    inactiveTrackColor: primaryCardTheme.color!,
                    activeColor: Theme.of(context).primaryColor,
                    activeTrackColor: Colors.grey.withAlpha(70),
                    title: const Text('Auto Repeating Transmission'),
                    value: (morseTranslationBloc.state as MorseTranslationInitial).isAutoRepeating,
                    onChanged: (bool value) {
                      // Update isAutoRepeatingEnabled
                      morseTranslationBloc.add(ToggleAutoRepeat(isAutoRepeating: value));
                    },
                  ),
                  const SizedBox(height: 50),
                  morseTranslationBloc.isTransmitting
                      ? OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: const Size(double.maxFinite, 50),
                        backgroundColor: primaryCardTheme.color,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        morseTranslationBloc.add(ToggleTransmitting(
                            morseCode: _textTranslatedController.text));
                      },
                      child: const Text('Stop transmitting'))
                      : OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: const Size(double.maxFinite, 50),
                        backgroundColor: Theme.of(context).hintColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        morseTranslationBloc.add(ToggleTransmitting(
                            morseCode: _textTranslatedController.text,
                        ));
                      },
                      child: const Text('Start transmitting')),
                ],
              ),
            );
          }
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(
          title: 'Morse Code Translator',
          enablePopButton: true,
        ),
        bottomNavigationBar: CustomBottomNavigation(),
        body: Stack(children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.58,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Column(children: <Widget>[
                Expanded(
                  flex: 4, // 40% of the available space
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: SingleChildScrollView(
                        child: BlocBuilder<MorseTranslationBloc,
                                MorseTranslationState>(
                            builder: (BuildContext context,
                                MorseTranslationState state) {
                          bool isTextFieldEnabled = true;
                          if (state is MorseTranslationInitial &&
                              state.languageSetting.languageSetting ==
                                  MorseLanguageSetting.none) {
                            isTextFieldEnabled = false;

                            _textEditingController.text =
                                state.languageSetting.inputText ?? '';
                          }

                          return TextField(
                            controller: _textEditingController,
                            enabled: isTextFieldEnabled,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: isTextFieldEnabled
                                  ? 'Vnesi besedilo...'
                                  : 'Izberi vrsto prevoda',
                              border: InputBorder.none,
                            ),
                            onChanged: _handleInputTranslation,
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  endIndent: 15,
                  indent: 15,
                  thickness: 1,
                ),
                Expanded(
                    flex: 6,
                    child: Stack(children: <Widget>[
                      BlocBuilder<MorseTranslationBloc, MorseTranslationState>(
                          builder: (BuildContext context,
                              MorseTranslationState state) {
                            _textTranslatedController.text =
                                state.languageSetting.translatedText ?? '';
                            return SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(
                                  maxLines: null,
                                  enabled: false,
                                  controller: _textTranslatedController,
                                  decoration: const InputDecoration(
                                    hintText: 'Prevod...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            );
                      }),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.flashlight_on_outlined),
                          onPressed: () {
                            showTorchSettingsBottomSheet(context);
                          },
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                  onPressed: () {
                                    _textEditingController.clear();
                                    _textTranslatedController.clear();
                                    BlocProvider.of<MorseTranslationBloc>(
                                            context)
                                        .add(ClearInput());
                                  },
                                  icon: const Icon(
                                      Icons.delete_outline_outlined)),
                              IconButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: _textTranslatedController.text));
                                  },
                                  icon: const Icon(Icons.copy_rounded))
                            ],
                          ))
                    ])),
              ]),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: IgnorePointer(
                ignoring: isKeyboardOpen,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child:
                      BlocBuilder<MorseTranslationBloc, MorseTranslationState>(
                    builder:
                        (BuildContext context, MorseTranslationState state) {
                      if (state is MorseTranslationInitial &&
                          state.languageSetting.languageSetting ==
                              MorseLanguageSetting.textToMorse) {
                        return _buildButtonsRow(context, 'Besedilo',
                            'assets/icons/morse_code_icon.svg');
                      } else if (state is MorseTranslationInitial &&
                          state.languageSetting.languageSetting ==
                              MorseLanguageSetting.morseToText) {
                        return _buildButtonsRow(context,
                            'assets/icons/morse_code_icon.svg', 'Besedilo');
                      } else {
                        // Create a button that will open a popup where the user can select the translation type
                        return _buildButtonsRow(
                            context, 'Izberi vrsto prevoda', null);
                      }
                    },
                  ),
                ),
              ))
        ]));
  }
}
