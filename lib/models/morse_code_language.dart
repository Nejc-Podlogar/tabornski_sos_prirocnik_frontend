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
}