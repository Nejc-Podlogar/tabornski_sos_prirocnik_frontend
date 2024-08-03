// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(selectedTopoCategory) =>
      "${Intl.select(selectedTopoCategory, {
            'geodetske_tocke': 'Geodetic points',
            'morje_in_morska_obala': 'The sea and the sea coast',
            'naselja_in_objekti': 'Settlements and facilities',
            'promet': 'Traffic',
            'rastje_in_vrste_tal': 'Growth and soil types',
            'relief': 'Relief',
            'vodovje': 'Water supply',
            'meje_in_ograje': 'Borders and fences',
            'other': 'Other',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "allowNotifications":
            MessageLookupByLibrary.simpleMessage("Allow notifications"),
        "amountOfRepetitions":
            MessageLookupByLibrary.simpleMessage("Amount of repetitions"),
        "appTitle": MessageLookupByLibrary.simpleMessage("Scouts S.O.S Manual"),
        "begin": MessageLookupByLibrary.simpleMessage("Begin"),
        "beginLearning": MessageLookupByLibrary.simpleMessage("Start learning"),
        "cardSwipe": MessageLookupByLibrary.simpleMessage("Cards"),
        "check": MessageLookupByLibrary.simpleMessage("Check"),
        "comingSoon": MessageLookupByLibrary.simpleMessage("Coming\nsoon"),
        "continuousTransmission":
            MessageLookupByLibrary.simpleMessage("Continuous transmission"),
        "correctAnswer": MessageLookupByLibrary.simpleMessage("Correct answer"),
        "correctAnswerWas":
            MessageLookupByLibrary.simpleMessage("Correct answer was"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark theme"),
        "deleteData": MessageLookupByLibrary.simpleMessage("Delete data"),
        "dictionary": MessageLookupByLibrary.simpleMessage("Dictionary"),
        "endOfExercise":
            MessageLookupByLibrary.simpleMessage("End of exercise"),
        "enterTranslation":
            MessageLookupByLibrary.simpleMessage("Enter translation"),
        "errorWhileValidating":
            MessageLookupByLibrary.simpleMessage("Error while validating"),
        "exercises": MessageLookupByLibrary.simpleMessage("Exercises"),
        "finishExercise":
            MessageLookupByLibrary.simpleMessage("Finish exercise"),
        "incorrectAnswer":
            MessageLookupByLibrary.simpleMessage("Incorrect answer"),
        "inputText": MessageLookupByLibrary.simpleMessage("Input text"),
        "introApplication": MessageLookupByLibrary.simpleMessage(
            "The application is primarily intended for scouts who want to learn the Morse and Semaphore alphabets and practice their knowledge of orientation. \nThe application contains a translator, dictionary, learning materials and exercises. \nIt also includes the possibility of learning topography. \nThe application is designed to be easy to use and allows learning in various ways."),
        "introMorseCode": MessageLookupByLibrary.simpleMessage(
            "In the Morse code alphabet you have several different tools available. \nYou have a translator to and from Morse code. \nYou can transmit translated text via the flashlight on your phone. \nThere are also learning materials available, which you can also download to your device. \nYou can also train on customized exercises to improve your knowledge of morse code."),
        "introSemaphore": MessageLookupByLibrary.simpleMessage(
            "In the Semaphore alphabet you have several different tools available. \nYou have a translator to and from Semaphore. \nThere are also learning materials available, which you can also download to your device. \nThere is also a separate list for all the characters and special symbols."),
        "introTopography": MessageLookupByLibrary.simpleMessage(
            "In orientation you have a lot of learning and revision materials available. \nAlso available separately are topographic signs, where you can learn and revise them with the help of customized exercises. \nTopographic signs used in the exercises are valid for the DTK25 map."),
        "keyboard": MessageLookupByLibrary.simpleMessage("Keyboard"),
        "learningType": MessageLookupByLibrary.simpleMessage("Learning type"),
        "letters": MessageLookupByLibrary.simpleMessage("Letters"),
        "manage": MessageLookupByLibrary.simpleMessage("Manage"),
        "materials": MessageLookupByLibrary.simpleMessage("Materials"),
        "morseCode": MessageLookupByLibrary.simpleMessage("Morse code"),
        "morseCodeAlphabet":
            MessageLookupByLibrary.simpleMessage("Morse code alphabet"),
        "morseCodeDescription": MessageLookupByLibrary.simpleMessage(
            "Morse code is a method used in telecommunication to encode text characters as sequences of two different signal durations, called dots and dashes or dits and dahses. Morse code is named after Samuel Morse, an inventor of the telegraph."),
        "morseCodeToText":
            MessageLookupByLibrary.simpleMessage("Morse code to text"),
        "nextExercise": MessageLookupByLibrary.simpleMessage("Next exercise"),
        "numbers": MessageLookupByLibrary.simpleMessage("Numbers"),
        "orientation": MessageLookupByLibrary.simpleMessage("Orientation"),
        "partiallyCorrectAnswer":
            MessageLookupByLibrary.simpleMessage("Partially correct answer"),
        "permissions": MessageLookupByLibrary.simpleMessage("Permissions"),
        "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
        "progress": MessageLookupByLibrary.simpleMessage("Progress"),
        "readMore": MessageLookupByLibrary.simpleMessage("Read more"),
        "receiving": MessageLookupByLibrary.simpleMessage("Receiving"),
        "selectFlags": MessageLookupByLibrary.simpleMessage("Select flags"),
        "selectTranslationType":
            MessageLookupByLibrary.simpleMessage("Select translation type"),
        "semaphore": MessageLookupByLibrary.simpleMessage("Semaphore"),
        "semaphoreAlphabet":
            MessageLookupByLibrary.simpleMessage("Semaphore alphabet"),
        "semaphoreDescription": MessageLookupByLibrary.simpleMessage(
            "Semaphore is a system of sending messages by holding the arms or two flags or poles in certain positions according to an alphabetic code."),
        "semaphoreToText":
            MessageLookupByLibrary.simpleMessage("Semaphore (flags) to text"),
        "sentences": MessageLookupByLibrary.simpleMessage("Sentences"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "sizeOfQuestion":
            MessageLookupByLibrary.simpleMessage("Size of the question"),
        "specialCharacters":
            MessageLookupByLibrary.simpleMessage("Special characters"),
        "startTransmitting":
            MessageLookupByLibrary.simpleMessage("Start transmitting"),
        "startUsingTheApp":
            MessageLookupByLibrary.simpleMessage("Start using the app"),
        "stopTransmitting":
            MessageLookupByLibrary.simpleMessage("Stop transmitting"),
        "text": MessageLookupByLibrary.simpleMessage("Text"),
        "textToMorseCode":
            MessageLookupByLibrary.simpleMessage("Text to Morse code"),
        "textToSemaphore":
            MessageLookupByLibrary.simpleMessage("Text to Semaphore (flags)"),
        "topoCategories": MessageLookupByLibrary.simpleMessage("Categories"),
        "topoCategory": m0,
        "topoImages": MessageLookupByLibrary.simpleMessage("Images"),
        "topoText": MessageLookupByLibrary.simpleMessage("Text"),
        "topography": MessageLookupByLibrary.simpleMessage("Topography"),
        "topographyLearning":
            MessageLookupByLibrary.simpleMessage("Topography learning"),
        "translateTheFollowingText": MessageLookupByLibrary.simpleMessage(
            "Translate the following text"),
        "translateTheFollowingTextDescription":
            MessageLookupByLibrary.simpleMessage(
                "To separate words please use /, \nTo separate letters use space."),
        "translatedText":
            MessageLookupByLibrary.simpleMessage("Translated text"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "translator": MessageLookupByLibrary.simpleMessage("Translator"),
        "transmitting": MessageLookupByLibrary.simpleMessage("Transmitting"),
        "user": MessageLookupByLibrary.simpleMessage("User"),
        "userInterface": MessageLookupByLibrary.simpleMessage("User interface"),
        "words": MessageLookupByLibrary.simpleMessage("Words")
      };
}
