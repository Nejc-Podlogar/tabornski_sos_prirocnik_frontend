// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Scouts S.O.S Manual`
  String get appTitle {
    return Intl.message(
      'Scouts S.O.S Manual',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message(
      'Read more',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `Coming\nsoon`
  String get comingSoon {
    return Intl.message(
      'Coming\nsoon',
      name: 'comingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Begin`
  String get begin {
    return Intl.message(
      'Begin',
      name: 'begin',
      desc: '',
      args: [],
    );
  }

  /// `The application is primarily intended for scouts who want to learn the Morse and Semaphore alphabets and practice their knowledge of orientation. \nThe application contains a translator, dictionary, learning materials and exercises. \nIt also includes the possibility of learning topography. \nThe application is designed to be easy to use and allows learning in various ways.`
  String get introApplication {
    return Intl.message(
      'The application is primarily intended for scouts who want to learn the Morse and Semaphore alphabets and practice their knowledge of orientation. \nThe application contains a translator, dictionary, learning materials and exercises. \nIt also includes the possibility of learning topography. \nThe application is designed to be easy to use and allows learning in various ways.',
      name: 'introApplication',
      desc: '',
      args: [],
    );
  }

  /// `In the Morse code alphabet you have several different tools available. \nYou have a translator to and from Morse code. \nYou can transmit translated text via the flashlight on your phone. \nThere are also learning materials available, which you can also download to your device. \nYou can also train on customized exercises to improve your knowledge of morse code.`
  String get introMorseCode {
    return Intl.message(
      'In the Morse code alphabet you have several different tools available. \nYou have a translator to and from Morse code. \nYou can transmit translated text via the flashlight on your phone. \nThere are also learning materials available, which you can also download to your device. \nYou can also train on customized exercises to improve your knowledge of morse code.',
      name: 'introMorseCode',
      desc: '',
      args: [],
    );
  }

  /// `In the Semaphore alphabet you have several different tools available. \nYou have a translator to and from Semaphore. \nThere are also learning materials available, which you can also download to your device. \nThere is also a separate list for all the characters and special symbols.`
  String get introSemaphore {
    return Intl.message(
      'In the Semaphore alphabet you have several different tools available. \nYou have a translator to and from Semaphore. \nThere are also learning materials available, which you can also download to your device. \nThere is also a separate list for all the characters and special symbols.',
      name: 'introSemaphore',
      desc: '',
      args: [],
    );
  }

  /// `In orientation you have a lot of learning and revision materials available. \nAlso available separately are topographic signs, where you can learn and revise them with the help of customized exercises. \nTopographic signs used in the exercises are valid for the DTK25 map.`
  String get introTopography {
    return Intl.message(
      'In orientation you have a lot of learning and revision materials available. \nAlso available separately are topographic signs, where you can learn and revise them with the help of customized exercises. \nTopographic signs used in the exercises are valid for the DTK25 map.',
      name: 'introTopography',
      desc: '',
      args: [],
    );
  }

  /// `Morse code`
  String get morseCode {
    return Intl.message(
      'Morse code',
      name: 'morseCode',
      desc: '',
      args: [],
    );
  }

  /// `Semaphore`
  String get semaphore {
    return Intl.message(
      'Semaphore',
      name: 'semaphore',
      desc: '',
      args: [],
    );
  }

  /// `Start using the app`
  String get startUsingTheApp {
    return Intl.message(
      'Start using the app',
      name: 'startUsingTheApp',
      desc: '',
      args: [],
    );
  }

  /// `Translator`
  String get translator {
    return Intl.message(
      'Translator',
      name: 'translator',
      desc: '',
      args: [],
    );
  }

  /// `Dictionary`
  String get dictionary {
    return Intl.message(
      'Dictionary',
      name: 'dictionary',
      desc: '',
      args: [],
    );
  }

  /// `Materials`
  String get materials {
    return Intl.message(
      'Materials',
      name: 'materials',
      desc: '',
      args: [],
    );
  }

  /// `Exercises`
  String get exercises {
    return Intl.message(
      'Exercises',
      name: 'exercises',
      desc: '',
      args: [],
    );
  }

  /// `Select translation type`
  String get selectTranslationType {
    return Intl.message(
      'Select translation type',
      name: 'selectTranslationType',
      desc: '',
      args: [],
    );
  }

  /// `Translation`
  String get translation {
    return Intl.message(
      'Translation',
      name: 'translation',
      desc: '',
      args: [],
    );
  }

  /// `Input text`
  String get inputText {
    return Intl.message(
      'Input text',
      name: 'inputText',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get text {
    return Intl.message(
      'Text',
      name: 'text',
      desc: '',
      args: [],
    );
  }

  /// `Enter translation`
  String get enterTranslation {
    return Intl.message(
      'Enter translation',
      name: 'enterTranslation',
      desc: '',
      args: [],
    );
  }

  /// `Letters`
  String get letters {
    return Intl.message(
      'Letters',
      name: 'letters',
      desc: '',
      args: [],
    );
  }

  /// `Numbers`
  String get numbers {
    return Intl.message(
      'Numbers',
      name: 'numbers',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Special characters`
  String get specialCharacters {
    return Intl.message(
      'Special characters',
      name: 'specialCharacters',
      desc: '',
      args: [],
    );
  }

  /// `Morse code alphabet`
  String get morseCodeAlphabet {
    return Intl.message(
      'Morse code alphabet',
      name: 'morseCodeAlphabet',
      desc: '',
      args: [],
    );
  }

  /// `Morse code is a method used in telecommunication to encode text characters as sequences of two different signal durations, called dots and dashes or dits and dahses. Morse code is named after Samuel Morse, an inventor of the telegraph.`
  String get morseCodeDescription {
    return Intl.message(
      'Morse code is a method used in telecommunication to encode text characters as sequences of two different signal durations, called dots and dashes or dits and dahses. Morse code is named after Samuel Morse, an inventor of the telegraph.',
      name: 'morseCodeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Text to Morse code`
  String get textToMorseCode {
    return Intl.message(
      'Text to Morse code',
      name: 'textToMorseCode',
      desc: '',
      args: [],
    );
  }

  /// `Morse code to text`
  String get morseCodeToText {
    return Intl.message(
      'Morse code to text',
      name: 'morseCodeToText',
      desc: '',
      args: [],
    );
  }

  /// `Start transmitting`
  String get startTransmitting {
    return Intl.message(
      'Start transmitting',
      name: 'startTransmitting',
      desc: '',
      args: [],
    );
  }

  /// `Stop transmitting`
  String get stopTransmitting {
    return Intl.message(
      'Stop transmitting',
      name: 'stopTransmitting',
      desc: '',
      args: [],
    );
  }

  /// `Continuous transmission`
  String get continuousTransmission {
    return Intl.message(
      'Continuous transmission',
      name: 'continuousTransmission',
      desc: '',
      args: [],
    );
  }

  /// `Transmitting`
  String get transmitting {
    return Intl.message(
      'Transmitting',
      name: 'transmitting',
      desc: '',
      args: [],
    );
  }

  /// `Receiving`
  String get receiving {
    return Intl.message(
      'Receiving',
      name: 'receiving',
      desc: '',
      args: [],
    );
  }

  /// `Learning type`
  String get learningType {
    return Intl.message(
      'Learning type',
      name: 'learningType',
      desc: '',
      args: [],
    );
  }

  /// `Size of the question`
  String get sizeOfQuestion {
    return Intl.message(
      'Size of the question',
      name: 'sizeOfQuestion',
      desc: '',
      args: [],
    );
  }

  /// `User interface`
  String get userInterface {
    return Intl.message(
      'User interface',
      name: 'userInterface',
      desc: '',
      args: [],
    );
  }

  /// `Amount of repetitions`
  String get amountOfRepetitions {
    return Intl.message(
      'Amount of repetitions',
      name: 'amountOfRepetitions',
      desc: '',
      args: [],
    );
  }

  /// `Words`
  String get words {
    return Intl.message(
      'Words',
      name: 'words',
      desc: '',
      args: [],
    );
  }

  /// `Sentences`
  String get sentences {
    return Intl.message(
      'Sentences',
      name: 'sentences',
      desc: '',
      args: [],
    );
  }

  /// `Start learning`
  String get beginLearning {
    return Intl.message(
      'Start learning',
      name: 'beginLearning',
      desc: '',
      args: [],
    );
  }

  /// `Cards`
  String get cardSwipe {
    return Intl.message(
      'Cards',
      name: 'cardSwipe',
      desc: '',
      args: [],
    );
  }

  /// `Keyboard`
  String get keyboard {
    return Intl.message(
      'Keyboard',
      name: 'keyboard',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress {
    return Intl.message(
      'Progress',
      name: 'progress',
      desc: '',
      args: [],
    );
  }

  /// `Check`
  String get check {
    return Intl.message(
      'Check',
      name: 'check',
      desc: '',
      args: [],
    );
  }

  /// `Translate the following text`
  String get translateTheFollowingText {
    return Intl.message(
      'Translate the following text',
      name: 'translateTheFollowingText',
      desc: '',
      args: [],
    );
  }

  /// `To separate words please use /, \nTo separate letters use space.`
  String get translateTheFollowingTextDescription {
    return Intl.message(
      'To separate words please use /, \nTo separate letters use space.',
      name: 'translateTheFollowingTextDescription',
      desc: '',
      args: [],
    );
  }

  /// `Next exercise`
  String get nextExercise {
    return Intl.message(
      'Next exercise',
      name: 'nextExercise',
      desc: '',
      args: [],
    );
  }

  /// `Correct answer`
  String get correctAnswer {
    return Intl.message(
      'Correct answer',
      name: 'correctAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect answer`
  String get incorrectAnswer {
    return Intl.message(
      'Incorrect answer',
      name: 'incorrectAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Partially correct answer`
  String get partiallyCorrectAnswer {
    return Intl.message(
      'Partially correct answer',
      name: 'partiallyCorrectAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Error while validating`
  String get errorWhileValidating {
    return Intl.message(
      'Error while validating',
      name: 'errorWhileValidating',
      desc: '',
      args: [],
    );
  }

  /// `End of exercise`
  String get endOfExercise {
    return Intl.message(
      'End of exercise',
      name: 'endOfExercise',
      desc: '',
      args: [],
    );
  }

  /// `Finish exercise`
  String get finishExercise {
    return Intl.message(
      'Finish exercise',
      name: 'finishExercise',
      desc: '',
      args: [],
    );
  }

  /// `Correct answer was`
  String get correctAnswerWas {
    return Intl.message(
      'Correct answer was',
      name: 'correctAnswerWas',
      desc: '',
      args: [],
    );
  }

  /// `Semaphore alphabet`
  String get semaphoreAlphabet {
    return Intl.message(
      'Semaphore alphabet',
      name: 'semaphoreAlphabet',
      desc: '',
      args: [],
    );
  }

  /// `Semaphore is a system of sending messages by holding the arms or two flags or poles in certain positions according to an alphabetic code.`
  String get semaphoreDescription {
    return Intl.message(
      'Semaphore is a system of sending messages by holding the arms or two flags or poles in certain positions according to an alphabetic code.',
      name: 'semaphoreDescription',
      desc: '',
      args: [],
    );
  }

  /// `Text to Semaphore (flags)`
  String get textToSemaphore {
    return Intl.message(
      'Text to Semaphore (flags)',
      name: 'textToSemaphore',
      desc: '',
      args: [],
    );
  }

  /// `Semaphore (flags) to text`
  String get semaphoreToText {
    return Intl.message(
      'Semaphore (flags) to text',
      name: 'semaphoreToText',
      desc: '',
      args: [],
    );
  }

  /// `Orientation`
  String get orientation {
    return Intl.message(
      'Orientation',
      name: 'orientation',
      desc: '',
      args: [],
    );
  }

  /// `Topography`
  String get topography {
    return Intl.message(
      'Topography',
      name: 'topography',
      desc: '',
      args: [],
    );
  }

  /// `Topography learning`
  String get topographyLearning {
    return Intl.message(
      'Topography learning',
      name: 'topographyLearning',
      desc: '',
      args: [],
    );
  }

  /// `Images`
  String get topoImages {
    return Intl.message(
      'Images',
      name: 'topoImages',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get topoText {
    return Intl.message(
      'Text',
      name: 'topoText',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get topoCategories {
    return Intl.message(
      'Categories',
      name: 'topoCategories',
      desc: '',
      args: [],
    );
  }

  /// `{selectedTopoCategory, select, geodetske_tocke{Geodetic points} morje_in_morska_obala{The sea and the sea coast} naselja_in_objekti{Settlements and facilities} promet{Traffic} rastje_in_vrste_tal{Growth and soil types} relief{Relief} vodovje{Water supply} meje_in_ograje{Borders and fences} other{Other}}`
  String topoCategory(Object selectedTopoCategory) {
    return Intl.select(
      selectedTopoCategory,
      {
        'geodetske_tocke': 'Geodetic points',
        'morje_in_morska_obala': 'The sea and the sea coast',
        'naselja_in_objekti': 'Settlements and facilities',
        'promet': 'Traffic',
        'rastje_in_vrste_tal': 'Growth and soil types',
        'relief': 'Relief',
        'vodovje': 'Water supply',
        'meje_in_ograje': 'Borders and fences',
        'other': 'Other',
      },
      name: 'topoCategory',
      desc: '',
      args: [selectedTopoCategory],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Preferences`
  String get preferences {
    return Intl.message(
      'Preferences',
      name: 'preferences',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get darkMode {
    return Intl.message(
      'Dark theme',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Allow notifications`
  String get allowNotifications {
    return Intl.message(
      'Allow notifications',
      name: 'allowNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Permissions`
  String get permissions {
    return Intl.message(
      'Permissions',
      name: 'permissions',
      desc: '',
      args: [],
    );
  }

  /// `Manage`
  String get manage {
    return Intl.message(
      'Manage',
      name: 'manage',
      desc: '',
      args: [],
    );
  }

  /// `Delete data`
  String get deleteData {
    return Intl.message(
      'Delete data',
      name: 'deleteData',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Translated text`
  String get translatedText {
    return Intl.message(
      'Translated text',
      name: 'translatedText',
      desc: '',
      args: [],
    );
  }

  /// `Select flags`
  String get selectFlags {
    return Intl.message(
      'Select flags',
      name: 'selectFlags',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'sl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
