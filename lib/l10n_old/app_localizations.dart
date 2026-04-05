import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_sl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('sl')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Scouts S.O.S Manual'**
  String get appTitle;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get readMore;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming\nsoon'**
  String get comingSoon;

  /// No description provided for @begin.
  ///
  /// In en, this message translates to:
  /// **'Begin'**
  String get begin;

  /// No description provided for @introApplication.
  ///
  /// In en, this message translates to:
  /// **'The application is primarily intended for scouts who want to learn the Morse and Semaphore alphabets and practice their knowledge of orientation. \nThe application contains a translator, dictionary, learning materials and exercises. \nIt also includes the possibility of learning topography. \nThe application is designed to be easy to use and allows learning in various ways.'**
  String get introApplication;

  /// No description provided for @introMorseCode.
  ///
  /// In en, this message translates to:
  /// **'In the Morse code alphabet you have several different tools available. \nYou have a translator to and from Morse code. \nYou can transmit translated text via the flashlight on your phone. \nThere are also learning materials available, which you can also download to your device. \nYou can also train on customized exercises to improve your knowledge of morse code.'**
  String get introMorseCode;

  /// No description provided for @introSemaphore.
  ///
  /// In en, this message translates to:
  /// **'In the Semaphore alphabet you have several different tools available. \nYou have a translator to and from Semaphore. \nThere are also learning materials available, which you can also download to your device. \nThere is also a separate list for all the characters and special symbols.'**
  String get introSemaphore;

  /// No description provided for @introTopography.
  ///
  /// In en, this message translates to:
  /// **'In orientation you have a lot of learning and revision materials available. \nAlso available separately are topographic signs, where you can learn and revise them with the help of customized exercises. \nTopographic signs used in the exercises are valid for the DTK25 map.'**
  String get introTopography;

  /// No description provided for @morseCode.
  ///
  /// In en, this message translates to:
  /// **'Morse code'**
  String get morseCode;

  /// No description provided for @semaphore.
  ///
  /// In en, this message translates to:
  /// **'Semaphore'**
  String get semaphore;

  /// No description provided for @startUsingTheApp.
  ///
  /// In en, this message translates to:
  /// **'Start using the app'**
  String get startUsingTheApp;

  /// No description provided for @translator.
  ///
  /// In en, this message translates to:
  /// **'Translator'**
  String get translator;

  /// No description provided for @dictionary.
  ///
  /// In en, this message translates to:
  /// **'Dictionary'**
  String get dictionary;

  /// No description provided for @materials.
  ///
  /// In en, this message translates to:
  /// **'Materials'**
  String get materials;

  /// No description provided for @exercises.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get exercises;

  /// No description provided for @selectTranslationType.
  ///
  /// In en, this message translates to:
  /// **'Select translation type'**
  String get selectTranslationType;

  /// No description provided for @translation.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translation;

  /// No description provided for @inputText.
  ///
  /// In en, this message translates to:
  /// **'Input text'**
  String get inputText;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get text;

  /// No description provided for @enterTranslation.
  ///
  /// In en, this message translates to:
  /// **'Enter translation'**
  String get enterTranslation;

  /// No description provided for @letters.
  ///
  /// In en, this message translates to:
  /// **'Letters'**
  String get letters;

  /// No description provided for @numbers.
  ///
  /// In en, this message translates to:
  /// **'Numbers'**
  String get numbers;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @specialCharacters.
  ///
  /// In en, this message translates to:
  /// **'Special characters'**
  String get specialCharacters;

  /// No description provided for @morseCodeAlphabet.
  ///
  /// In en, this message translates to:
  /// **'Morse code alphabet'**
  String get morseCodeAlphabet;

  /// No description provided for @morseCodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Morse code is a method used in telecommunication to encode text characters as sequences of two different signal durations, called dots and dashes or dits and dahses. Morse code is named after Samuel Morse, an inventor of the telegraph.'**
  String get morseCodeDescription;

  /// No description provided for @textToMorseCode.
  ///
  /// In en, this message translates to:
  /// **'Text to Morse code'**
  String get textToMorseCode;

  /// No description provided for @morseCodeToText.
  ///
  /// In en, this message translates to:
  /// **'Morse code to text'**
  String get morseCodeToText;

  /// No description provided for @startTransmitting.
  ///
  /// In en, this message translates to:
  /// **'Start transmitting'**
  String get startTransmitting;

  /// No description provided for @stopTransmitting.
  ///
  /// In en, this message translates to:
  /// **'Stop transmitting'**
  String get stopTransmitting;

  /// No description provided for @continuousTransmission.
  ///
  /// In en, this message translates to:
  /// **'Continuous transmission'**
  String get continuousTransmission;

  /// No description provided for @transmitting.
  ///
  /// In en, this message translates to:
  /// **'Transmitting'**
  String get transmitting;

  /// No description provided for @receiving.
  ///
  /// In en, this message translates to:
  /// **'Receiving'**
  String get receiving;

  /// No description provided for @learningType.
  ///
  /// In en, this message translates to:
  /// **'Learning type'**
  String get learningType;

  /// No description provided for @sizeOfQuestion.
  ///
  /// In en, this message translates to:
  /// **'Size of the question'**
  String get sizeOfQuestion;

  /// No description provided for @userInterface.
  ///
  /// In en, this message translates to:
  /// **'User interface'**
  String get userInterface;

  /// No description provided for @amountOfRepetitions.
  ///
  /// In en, this message translates to:
  /// **'Amount of repetitions'**
  String get amountOfRepetitions;

  /// No description provided for @words.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get words;

  /// No description provided for @sentences.
  ///
  /// In en, this message translates to:
  /// **'Sentences'**
  String get sentences;

  /// No description provided for @beginLearning.
  ///
  /// In en, this message translates to:
  /// **'Start learning'**
  String get beginLearning;

  /// No description provided for @cardSwipe.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get cardSwipe;

  /// No description provided for @keyboard.
  ///
  /// In en, this message translates to:
  /// **'Keyboard'**
  String get keyboard;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @translateTheFollowingText.
  ///
  /// In en, this message translates to:
  /// **'Translate the following text'**
  String get translateTheFollowingText;

  /// No description provided for @translateTheFollowingTextDescription.
  ///
  /// In en, this message translates to:
  /// **'To separate words please use /, \nTo separate letters use space.'**
  String get translateTheFollowingTextDescription;

  /// No description provided for @nextExercise.
  ///
  /// In en, this message translates to:
  /// **'Next exercise'**
  String get nextExercise;

  /// No description provided for @correctAnswer.
  ///
  /// In en, this message translates to:
  /// **'Correct answer'**
  String get correctAnswer;

  /// No description provided for @incorrectAnswer.
  ///
  /// In en, this message translates to:
  /// **'Incorrect answer'**
  String get incorrectAnswer;

  /// No description provided for @partiallyCorrectAnswer.
  ///
  /// In en, this message translates to:
  /// **'Partially correct answer'**
  String get partiallyCorrectAnswer;

  /// No description provided for @errorWhileValidating.
  ///
  /// In en, this message translates to:
  /// **'Error while validating'**
  String get errorWhileValidating;

  /// No description provided for @endOfExercise.
  ///
  /// In en, this message translates to:
  /// **'End of exercise'**
  String get endOfExercise;

  /// No description provided for @finishExercise.
  ///
  /// In en, this message translates to:
  /// **'Finish exercise'**
  String get finishExercise;

  /// No description provided for @correctAnswerWas.
  ///
  /// In en, this message translates to:
  /// **'Correct answer was'**
  String get correctAnswerWas;

  /// No description provided for @semaphoreAlphabet.
  ///
  /// In en, this message translates to:
  /// **'Semaphore alphabet'**
  String get semaphoreAlphabet;

  /// No description provided for @semaphoreDescription.
  ///
  /// In en, this message translates to:
  /// **'Semaphore is a system of sending messages by holding the arms or two flags or poles in certain positions according to an alphabetic code.'**
  String get semaphoreDescription;

  /// No description provided for @textToSemaphore.
  ///
  /// In en, this message translates to:
  /// **'Text to Semaphore (flags)'**
  String get textToSemaphore;

  /// No description provided for @semaphoreToText.
  ///
  /// In en, this message translates to:
  /// **'Semaphore (flags) to text'**
  String get semaphoreToText;

  /// No description provided for @orientation.
  ///
  /// In en, this message translates to:
  /// **'Orientation'**
  String get orientation;

  /// No description provided for @orientationDescription.
  ///
  /// In en, this message translates to:
  /// **'Orientation helps scouts find direction, navigate in nature, and reach their destination using a compass, map, and natural signs.'**
  String get orientationDescription;

  /// No description provided for @topography.
  ///
  /// In en, this message translates to:
  /// **'Topography'**
  String get topography;

  /// No description provided for @topographyLearning.
  ///
  /// In en, this message translates to:
  /// **'Topography learning'**
  String get topographyLearning;

  /// No description provided for @topoImages.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get topoImages;

  /// No description provided for @topoText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get topoText;

  /// No description provided for @topoCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get topoCategories;

  /// No description provided for @topoCategory.
  ///
  /// In en, this message translates to:
  /// **'{selectedTopoCategory, select, geodetske_tocke{Geodetic points} morje_in_morska_obala{The sea and the sea coast} naselja_in_objekti{Settlements and facilities} promet{Traffic} rastje_in_vrste_tal{Growth and soil types} relief{Relief} vodovje{Water supply} meje_in_ograje{Borders and fences} other{Other}}'**
  String topoCategory(String selectedTopoCategory);

  /// No description provided for @orientationMoreComingSoon.
  ///
  /// In en, this message translates to:
  /// **'More categories are coming soon.'**
  String get orientationMoreComingSoon;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get darkMode;

  /// No description provided for @allowNotifications.
  ///
  /// In en, this message translates to:
  /// **'Allow notifications'**
  String get allowNotifications;

  /// No description provided for @permissions.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissions;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// No description provided for @deleteData.
  ///
  /// In en, this message translates to:
  /// **'Delete data'**
  String get deleteData;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @translatedText.
  ///
  /// In en, this message translates to:
  /// **'Translated text'**
  String get translatedText;

  /// No description provided for @selectFlags.
  ///
  /// In en, this message translates to:
  /// **'Select flags'**
  String get selectFlags;

  /// No description provided for @tabornski_sos_prirocnik_frontend.
  ///
  /// In en, this message translates to:
  /// **'Scouts S.O.S Manual'**
  String get tabornski_sos_prirocnik_frontend;

  /// No description provided for @homeWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Taborniški S.O.S Priročnik is a cross-platform application designed for learning and digitalizing scout knowledge. It offers users an interactive way to explore Morse code, semaphore, topography, and orientation through translators, flashcards, and quizzes. The app features an intuitive user interface with clearly structured content and thematically tailored screens. Special attention is given to practical features, such as sending Morse messages via a phone flashlight. Built with Flutter, it ensures a consistent experience across Android, iOS, and web platforms.'**
  String get homeWelcomeMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'sl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'sl':
      return AppLocalizationsSl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
