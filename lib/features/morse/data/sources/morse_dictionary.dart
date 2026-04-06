/// International Morse Code dictionary including A–Z, 0–9 and Slovenian chars.
class MorseDictionary {
  MorseDictionary._();

  static const Map<String, String> charToMorse = {
    // Letters
    'A': '.-',   'B': '-...', 'C': '-.-.', 'D': '-..',
    'E': '.',    'F': '..-.', 'G': '--.',  'H': '....',
    'I': '..',   'J': '.---', 'K': '-.-',  'L': '.-..',
    'M': '--',   'N': '-.',   'O': '---',  'P': '.--.',
    'Q': '--.-', 'R': '.-.',  'S': '...',  'T': '-',
    'U': '..-',  'V': '...-', 'W': '.--',  'X': '-..-',
    'Y': '-.--', 'Z': '--..',
    // Slovenian characters (ITU prosigns, no collisions with A–Z)
    'Š': '...---', 'Č': '--.-.',  'Ž': '--..-',
    // Digits
    '0': '-----', '1': '.----', '2': '..---', '3': '...--',
    '4': '....-', '5': '.....', '6': '-....', '7': '--...',
    '8': '---..', '9': '----.',
  };

  static final Map<String, String> morseToChar = {
    for (final e in charToMorse.entries) e.value: e.key,
  };
}
