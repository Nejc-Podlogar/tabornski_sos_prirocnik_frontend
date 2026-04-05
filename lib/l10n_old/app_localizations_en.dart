// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Scouts S.O.S Manual';

  @override
  String get readMore => 'Read more';

  @override
  String get comingSoon => 'Coming\nsoon';

  @override
  String get begin => 'Begin';

  @override
  String get introApplication =>
      'The application is primarily intended for scouts who want to learn the Morse and Semaphore alphabets and practice their knowledge of orientation. \nThe application contains a translator, dictionary, learning materials and exercises. \nIt also includes the possibility of learning topography. \nThe application is designed to be easy to use and allows learning in various ways.';

  @override
  String get introMorseCode =>
      'In the Morse code alphabet you have several different tools available. \nYou have a translator to and from Morse code. \nYou can transmit translated text via the flashlight on your phone. \nThere are also learning materials available, which you can also download to your device. \nYou can also train on customized exercises to improve your knowledge of morse code.';

  @override
  String get introSemaphore =>
      'In the Semaphore alphabet you have several different tools available. \nYou have a translator to and from Semaphore. \nThere are also learning materials available, which you can also download to your device. \nThere is also a separate list for all the characters and special symbols.';

  @override
  String get introTopography =>
      'In orientation you have a lot of learning and revision materials available. \nAlso available separately are topographic signs, where you can learn and revise them with the help of customized exercises. \nTopographic signs used in the exercises are valid for the DTK25 map.';

  @override
  String get morseCode => 'Morse code';

  @override
  String get semaphore => 'Semaphore';

  @override
  String get startUsingTheApp => 'Start using the app';

  @override
  String get translator => 'Translator';

  @override
  String get dictionary => 'Dictionary';

  @override
  String get materials => 'Materials';

  @override
  String get exercises => 'Exercises';

  @override
  String get selectTranslationType => 'Select translation type';

  @override
  String get translation => 'Translation';

  @override
  String get inputText => 'Input text';

  @override
  String get text => 'Text';

  @override
  String get enterTranslation => 'Enter translation';

  @override
  String get letters => 'Letters';

  @override
  String get numbers => 'Numbers';

  @override
  String get all => 'All';

  @override
  String get specialCharacters => 'Special characters';

  @override
  String get morseCodeAlphabet => 'Morse code alphabet';

  @override
  String get morseCodeDescription =>
      'Morse code is a method used in telecommunication to encode text characters as sequences of two different signal durations, called dots and dashes or dits and dahses. Morse code is named after Samuel Morse, an inventor of the telegraph.';

  @override
  String get textToMorseCode => 'Text to Morse code';

  @override
  String get morseCodeToText => 'Morse code to text';

  @override
  String get startTransmitting => 'Start transmitting';

  @override
  String get stopTransmitting => 'Stop transmitting';

  @override
  String get continuousTransmission => 'Continuous transmission';

  @override
  String get transmitting => 'Transmitting';

  @override
  String get receiving => 'Receiving';

  @override
  String get learningType => 'Learning type';

  @override
  String get sizeOfQuestion => 'Size of the question';

  @override
  String get userInterface => 'User interface';

  @override
  String get amountOfRepetitions => 'Amount of repetitions';

  @override
  String get words => 'Words';

  @override
  String get sentences => 'Sentences';

  @override
  String get beginLearning => 'Start learning';

  @override
  String get cardSwipe => 'Cards';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get progress => 'Progress';

  @override
  String get check => 'Check';

  @override
  String get translateTheFollowingText => 'Translate the following text';

  @override
  String get translateTheFollowingTextDescription =>
      'To separate words please use /, \nTo separate letters use space.';

  @override
  String get nextExercise => 'Next exercise';

  @override
  String get correctAnswer => 'Correct answer';

  @override
  String get incorrectAnswer => 'Incorrect answer';

  @override
  String get partiallyCorrectAnswer => 'Partially correct answer';

  @override
  String get errorWhileValidating => 'Error while validating';

  @override
  String get endOfExercise => 'End of exercise';

  @override
  String get finishExercise => 'Finish exercise';

  @override
  String get correctAnswerWas => 'Correct answer was';

  @override
  String get semaphoreAlphabet => 'Semaphore alphabet';

  @override
  String get semaphoreDescription =>
      'Semaphore is a system of sending messages by holding the arms or two flags or poles in certain positions according to an alphabetic code.';

  @override
  String get textToSemaphore => 'Text to Semaphore (flags)';

  @override
  String get semaphoreToText => 'Semaphore (flags) to text';

  @override
  String get orientation => 'Orientation';

  @override
  String get orientationDescription =>
      'Orientation helps scouts find direction, navigate in nature, and reach their destination using a compass, map, and natural signs.';

  @override
  String get topography => 'Topography';

  @override
  String get topographyLearning => 'Topography learning';

  @override
  String get topoImages => 'Images';

  @override
  String get topoText => 'Text';

  @override
  String get topoCategories => 'Categories';

  @override
  String topoCategory(String selectedTopoCategory) {
    String _temp0 = intl.Intl.selectLogic(
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
    );
    return '$_temp0';
  }

  @override
  String get orientationMoreComingSoon => 'More categories are coming soon.';

  @override
  String get user => 'User';

  @override
  String get settings => 'Settings';

  @override
  String get preferences => 'Preferences';

  @override
  String get darkMode => 'Dark theme';

  @override
  String get allowNotifications => 'Allow notifications';

  @override
  String get permissions => 'Permissions';

  @override
  String get manage => 'Manage';

  @override
  String get deleteData => 'Delete data';

  @override
  String get about => 'About';

  @override
  String get translatedText => 'Translated text';

  @override
  String get selectFlags => 'Select flags';

  @override
  String get tabornski_sos_prirocnik_frontend => 'Scouts S.O.S Manual';

  @override
  String get homeWelcomeMessage =>
      'Taborniški S.O.S Priročnik is a cross-platform application designed for learning and digitalizing scout knowledge. It offers users an interactive way to explore Morse code, semaphore, topography, and orientation through translators, flashcards, and quizzes. The app features an intuitive user interface with clearly structured content and thematically tailored screens. Special attention is given to practical features, such as sending Morse messages via a phone flashlight. Built with Flutter, it ensures a consistent experience across Android, iOS, and web platforms.';
}
