class MorseCodeRepository {
  final Map<String, String> _morseCodeMapping = {
    'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.', 'F': '..-.',
    'G': '--.', 'H': '....', 'I': '..', 'J': '.---', 'K': '-.-', 'L': '.-..',
    'M': '--', 'N': '-.', 'O': '---', 'P': '.--.', 'Q': '--.-', 'R': '.-.',
    'S': '...', 'T': '-', 'U': '..-', 'V': '...-', 'W': '.--', 'X': '-..-',
    'Y': '-.--', 'Z': '--..', '1': '.----', '2': '..---', '3': '...--',
    '4': '....-', '5': '.....', '6': '-....', '7': '--...', '8': '---..',
    '9': '----.', '0': '-----', ' ': '/', '\n': '\n'
  };


  String translateToMorseCode(String text) {
    return text.toUpperCase().split('').map((char) => _morseCodeMapping[char] ?? '').join(' ');
  }

  String translateToText(String morseCode) {
    final Map<String, String> _textMapping = _morseCodeMapping.map((k, v) => MapEntry(v, k));

    return morseCode.split(' ').map((code) => _textMapping[code] ?? '').join('').toLowerCase();
  }
}