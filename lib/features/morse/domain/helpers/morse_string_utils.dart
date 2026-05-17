abstract final class MorseStringUtils {
  static final _morsePattern = RegExp(r'^[.\- /]+$');

  static bool isMorseSequence(String s) =>
      _morsePattern.hasMatch(s.trim());
}
