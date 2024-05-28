

class Convertors {

  static String convertFlagTitleToReadableText(String flagTitle) {
    // remove all { and } characters. Also if the text is ' ' replace it with the word space
    return (flagTitle == ' ') ? 'space' : flagTitle.replaceAll(RegExp(r'[{}]+'), '');
  }

}