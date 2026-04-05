enum SemaphoreLanguageSetting {
  textToFlags,
  flagsToText,
  none
}

enum FilterSemaphoreType {
  All,
  Letters,
  Numbers,
  Special,
}

class SemaphoreLanguage {
  final SemaphoreLanguageSetting semaphoreSetting;
  final String? text;
  final List<String>? flags;

  SemaphoreLanguage({this.semaphoreSetting = SemaphoreLanguageSetting.none, this.text, this.flags});

  SemaphoreLanguage copyWith({SemaphoreLanguageSetting? semaphoreSetting, String? text, List<String>? flags}) {
    return SemaphoreLanguage(
      semaphoreSetting: semaphoreSetting ?? this.semaphoreSetting,
      text: text ?? this.text,
      flags: flags ?? this.flags
    );
  }


  static final semaphoreList = [
    SemaphoreElement(letter: 'A', flagImageURL: 'assets/images/semaphore/flags/A_1.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'B', flagImageURL: 'assets/images/semaphore/flags/B_2.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'C', flagImageURL: 'assets/images/semaphore/flags/C_3.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'Č', flagImageURL: 'assets/images/semaphore/flags/C_3.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'D', flagImageURL: 'assets/images/semaphore/flags/D_4.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'E', flagImageURL: 'assets/images/semaphore/flags/E_5.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'F', flagImageURL: 'assets/images/semaphore/flags/F_6.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'G', flagImageURL: 'assets/images/semaphore/flags/G_7.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'H', flagImageURL: 'assets/images/semaphore/flags/H_8.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'I', flagImageURL: 'assets/images/semaphore/flags/I_9.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'J', flagImageURL: 'assets/images/semaphore/flags/J.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'K', flagImageURL: 'assets/images/semaphore/flags/K_0.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'L', flagImageURL: 'assets/images/semaphore/flags/L.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'M', flagImageURL: 'assets/images/semaphore/flags/M.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'N', flagImageURL: 'assets/images/semaphore/flags/N.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'O', flagImageURL: 'assets/images/semaphore/flags/O.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'P', flagImageURL: 'assets/images/semaphore/flags/P.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'Q', flagImageURL: 'assets/images/semaphore/flags/Q.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'R', flagImageURL: 'assets/images/semaphore/flags/R.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'S', flagImageURL: 'assets/images/semaphore/flags/S.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'Š', flagImageURL: 'assets/images/semaphore/flags/S.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'T', flagImageURL: 'assets/images/semaphore/flags/T.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'U', flagImageURL: 'assets/images/semaphore/flags/U.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'V', flagImageURL: 'assets/images/semaphore/flags/V.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'W', flagImageURL: 'assets/images/semaphore/flags/W.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'X', flagImageURL: 'assets/images/semaphore/flags/X.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'Y', flagImageURL: 'assets/images/semaphore/flags/Y.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'Z', flagImageURL: 'assets/images/semaphore/flags/Z.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: 'Ž', flagImageURL: 'assets/images/semaphore/flags/Z.png', filterType: FilterSemaphoreType.Letters),
    SemaphoreElement(letter: '1', flagImageURL: 'assets/images/semaphore/flags/A_1.png', filterType: FilterSemaphoreType.Numbers),
    SemaphoreElement(letter: '2', flagImageURL: 'assets/images/semaphore/flags/B_2.png', filterType: FilterSemaphoreType.Numbers),
    SemaphoreElement(letter: '3', flagImageURL: 'assets/images/semaphore/flags/C_3.png', filterType: FilterSemaphoreType.Numbers),
    SemaphoreElement(letter: '4', flagImageURL: 'assets/images/semaphore/flags/D_4.png', filterType: FilterSemaphoreType.Numbers),
    SemaphoreElement(letter: '5', flagImageURL: 'assets/images/semaphore/flags/E_5.png', filterType: FilterSemaphoreType.Numbers),
    SemaphoreElement(letter: '6', flagImageURL: 'assets/images/semaphore/flags/F_6.png', filterType: FilterSemaphoreType.Numbers),
    SemaphoreElement(letter: '7', flagImageURL: 'assets/images/semaphore/flags/G_7.png', filterType: FilterSemaphoreType.Numbers),
    SemaphoreElement(letter: '8', flagImageURL: 'assets/images/semaphore/flags/H_8.png', filterType: FilterSemaphoreType.Numbers),
    SemaphoreElement(letter: '9', flagImageURL: 'assets/images/semaphore/flags/I_9.png', filterType: FilterSemaphoreType.Numbers),
    SemaphoreElement(letter: '0', flagImageURL: 'assets/images/semaphore/flags/K_0.png', filterType: FilterSemaphoreType.Numbers),
    SemaphoreElement(letter: ' ', flagImageURL: 'assets/images/semaphore/flags/space.png', filterType: FilterSemaphoreType.Special),
    SemaphoreElement(letter: '{error}', flagImageURL: 'assets/images/semaphore/flags/error.png', filterType: FilterSemaphoreType.Special),
    SemaphoreElement(letter: '{cancel}', flagImageURL: 'assets/images/semaphore/flags/cancel.png', filterType: FilterSemaphoreType.Special),
    SemaphoreElement(letter: '{letters to follow}', flagImageURL: 'assets/images/semaphore/flags/letters.png', filterType: FilterSemaphoreType.Special),
    SemaphoreElement(letter: '{numbers to follow}', flagImageURL: 'assets/images/semaphore/flags/numerals.png', filterType: FilterSemaphoreType.Special),
  ];

}

class SemaphoreElement {
  final String letter;
  final String? flagImageURL;
  final FilterSemaphoreType filterType;

  SemaphoreElement({required this.letter, required this.flagImageURL, required this.filterType});
}