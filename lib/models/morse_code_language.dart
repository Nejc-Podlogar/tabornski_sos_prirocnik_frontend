enum MorseLanguageSetting {
  textToMorse,
  morseToText,
  none
}

class MorseCodeLanguage {
  final MorseLanguageSetting languageSetting;
  final String? inputText;
  final String? translatedText;


  MorseCodeLanguage({this.languageSetting = MorseLanguageSetting.none, this.inputText, this.translatedText});

  MorseCodeLanguage copyWith({MorseLanguageSetting? languageSetting, String? inputText, String? translatedText}) {
    return MorseCodeLanguage(
      languageSetting: languageSetting ?? this.languageSetting,
      inputText: inputText ?? this.inputText,
      translatedText: translatedText ?? this.translatedText,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MorseCodeLanguage &&
          runtimeType == other.runtimeType &&
          languageSetting == other.languageSetting;

  @override
  int get hashCode => languageSetting.hashCode;


  // Create the MorseCodeLanguage for every known translation for morse code
  static final morseCodeList = [
    MorseCodeElement(letter: 'A', morseCode: '.-', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'B', morseCode: '-...', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'C', morseCode: '-.-.', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'D', morseCode: '-..', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'E', morseCode: '.', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'F', morseCode: '..-.', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'G', morseCode: '--.', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'H', morseCode: '....', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'I', morseCode: '..', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'J', morseCode: '.---', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'K', morseCode: '-.-', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'L', morseCode: '.-..', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'M', morseCode: '--', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'N', morseCode: '-.', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'O', morseCode: '---', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'P', morseCode: '.--.', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'Q', morseCode: '--.-', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'R', morseCode: '.-.', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'S', morseCode: '...', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'T', morseCode: '-', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'U', morseCode: '..-', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'V', morseCode: '...-', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'W', morseCode: '.--', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'X', morseCode: '-..-', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'Y', morseCode: '-.--', filterType: FilterType.Letters),
    MorseCodeElement(letter: 'Z', morseCode: '--..', filterType: FilterType.Letters),
    MorseCodeElement(letter: '1', morseCode: '.----', filterType: FilterType.Numbers),
    MorseCodeElement(letter: '2', morseCode: '..---', filterType: FilterType.Numbers),
    MorseCodeElement(letter: '3', morseCode: '...--', filterType: FilterType.Numbers),
    MorseCodeElement(letter: '4', morseCode: '....-', filterType: FilterType.Numbers),
    MorseCodeElement(letter: '5', morseCode: '.....', filterType: FilterType.Numbers),
    MorseCodeElement(letter: '6', morseCode: '-....', filterType: FilterType.Numbers),
    MorseCodeElement(letter: '7', morseCode: '--...', filterType: FilterType.Numbers),
    MorseCodeElement(letter: '8', morseCode: '---..', filterType: FilterType.Numbers),
    MorseCodeElement(letter: '9', morseCode: '----.', filterType: FilterType.Numbers),
    MorseCodeElement(letter: '0', morseCode: '-----', filterType: FilterType.Numbers),
  ];
}

class MorseCodeElement {
  final String letter;
  final String morseCode;
  final FilterType filterType;

  MorseCodeElement({required this.letter, required this.morseCode, this.filterType = FilterType.All});

}

enum FilterType {
  All,
  Letters,
  Numbers
}


