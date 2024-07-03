import '../models/morse_code_language.dart';

class MorseCodeRepository {
  final Map<String, String> _morseCodeMapping = {
    'A': '.-',
    'B': '-...',
    'C': '-.-.',
    'D': '-..',
    'E': '.',
    'F': '..-.',
    'G': '--.',
    'H': '....',
    'I': '..',
    'J': '.---',
    'K': '-.-',
    'L': '.-..',
    'M': '--',
    'N': '-.',
    'O': '---',
    'P': '.--.',
    'Q': '--.-',
    'R': '.-.',
    'S': '...',
    'T': '-',
    'U': '..-',
    'V': '...-',
    'W': '.--',
    'X': '-..-',
    'Y': '-.--',
    'Z': '--..',
    '1': '.----',
    '2': '..---',
    '3': '...--',
    '4': '....-',
    '5': '.....',
    '6': '-....',
    '7': '--...',
    '8': '---..',
    '9': '----.',
    '0': '-----',
    ' ': '/',
    '\n': '\n'
  };

  String translateToMorseCode(String text) {
    return text
        .toUpperCase()
        .split('')
        .map((char) => _morseCodeMapping[char] ?? '')
        .join(' ');
  }

  String translateToText(String morseCode) {
    final Map<String, String> _textMapping =
        _morseCodeMapping.map((k, v) => MapEntry(v, k));

    return morseCode
        .split(' ')
        .map((code) => _textMapping[code] ?? '')
        .join('')
        .toLowerCase();
  }

  String replaceSlovenianLetters(String text) {
    return text
        .replaceAll('Č', 'C')
        .replaceAll('Š', 'S')
        .replaceAll('Ž', 'Z')
        .replaceAll('Ć', 'C')
        .replaceAll('Đ', 'D');
  }

  MorseCodeValidation validateTranslation(
      String text,
      String expectedValue,
      MorseCodeLearningAmount valueAmount,
      MorseLanguageSetting translationType) {
    //return true;

    // If translationType is textToMorse, and valueAmount is words, then we need to compare the text to the expected value.


    if (translationType == MorseLanguageSetting.textToMorse) {

      if (valueAmount == MorseCodeLearningAmount.words) {
        final List<String> textLetters = text.toUpperCase().trim().split(' ');
        final List<String> expectedLetters = expectedValue.toUpperCase().trim().split(' ');

        int correctLetters = 0;
        int incorrectLetters = 0;

        for (int i = 0; i < textLetters.length; i++) {
          if (textLetters[i] == expectedLetters[i]) {
            correctLetters++;
          } else {
            incorrectLetters++;
          }
        }

        if (correctLetters == textLetters.length) {
          return MorseCodeValidation.correct;
        } else if (incorrectLetters > correctLetters) {
          return MorseCodeValidation.incorrect;
        } else {
          return MorseCodeValidation.partial;
        }
      }else if (valueAmount == MorseCodeLearningAmount.sentences) {
        // We need to compare sentences in this case. The sentences are separated by a / character.
        // The letters in the text variable are separated by spaces. If every word in completely correct, then return MorseCodeValidation.correct,
        // if there is more incorrect words than correct words, then return MorseCodeValidation.incorrect, otherwise return MorseCodeValidation.partial

        final List<String> textSentences = text.toUpperCase().trim().split('/');
        final List<String> expectedSentences = expectedValue.toUpperCase().trim().split('/');

        int correctSentences = 0;
        int incorrectSentences = 0;

        for (int i = 0; i < textSentences.length; i++) {
          if (textSentences[i] == expectedSentences[i]) {
            correctSentences++;
          } else {
            incorrectSentences++;
          }
        }

        if (correctSentences == textSentences.length) {
          return MorseCodeValidation.correct;
        } else if (incorrectSentences > correctSentences) {
          return MorseCodeValidation.incorrect;
        } else {
          return MorseCodeValidation.partial;
        }

      } else if (valueAmount == MorseCodeLearningAmount.letters) {

        if (text.toUpperCase().trim() == expectedValue.toUpperCase().trim()) {
          return MorseCodeValidation.correct;
        } else {
          return MorseCodeValidation.incorrect;
        }

      }

    } else {

      if (valueAmount == MorseCodeLearningAmount.words) {
        final List<String> textLetters = replaceSlovenianLetters(text.toUpperCase().trim()).split('');
        final List<String> expectedLetters = replaceSlovenianLetters(expectedValue.toUpperCase().trim()).split('');

        int correctLetters = 0;
        int incorrectLetters = 0;

        for (int i = 0; i < textLetters.length; i++) {
          if (textLetters[i] == expectedLetters[i]) {
            correctLetters++;
          } else {
            incorrectLetters++;
          }
        }

        if (correctLetters == textLetters.length) {
          return MorseCodeValidation.correct;
        } else if (incorrectLetters > correctLetters) {
          return MorseCodeValidation.incorrect;
        } else {
          return MorseCodeValidation.partial;
        }
      }else if (valueAmount == MorseCodeLearningAmount.sentences) {
        // We need to compare sentences in this case. The sentences are separated by a / character.
        // The letters in the text variable are separated by spaces. If every word in completely correct, then return MorseCodeValidation.correct,
        // if there is more incorrect words than correct words, then return MorseCodeValidation.incorrect, otherwise return MorseCodeValidation.partial

        final List<String> textSentences = replaceSlovenianLetters(text.toUpperCase().trim()).split('/');
        final List<String> expectedSentences = replaceSlovenianLetters(expectedValue.toUpperCase().trim()).split('/');

        int correctSentences = 0;
        int incorrectSentences = 0;

        for (int i = 0; i < textSentences.length; i++) {
          if (textSentences[i] == expectedSentences[i]) {
            correctSentences++;
          } else {
            incorrectSentences++;
          }
        }

        if (correctSentences == textSentences.length) {
          return MorseCodeValidation.correct;
        } else if (incorrectSentences > correctSentences) {
          return MorseCodeValidation.incorrect;
        } else {
          return MorseCodeValidation.partial;
        }

      } else if (valueAmount == MorseCodeLearningAmount.letters) {

        if (replaceSlovenianLetters(text.toUpperCase().trim()) == replaceSlovenianLetters(expectedValue.toUpperCase().trim())) {
          return MorseCodeValidation.correct;
        } else {
          return MorseCodeValidation.incorrect;
        }

      }


    }

    return MorseCodeValidation.failed;

  }
}
