
import 'package:tabornski_sos_prirocnik_frontend/models/semaphore.dart';
import 'package:collection/collection.dart';

enum CurrentSemaphoreType {
  letter,
  number,
}


class SemaphoreRepository {

  String translateSemaphoreToText(List<String> semaphoreList) {
    CurrentSemaphoreType semaphoreType = CurrentSemaphoreType.letter;

    String result = '';

    for (var flag in semaphoreList) {
      if (flag == 'assets/images/semaphore/flags/letters.png') {
        semaphoreType = CurrentSemaphoreType.letter;
        continue;
      } else if (flag == 'assets/images/semaphore/flags/numerals.png') {
        semaphoreType = CurrentSemaphoreType.number;
        continue;
      }

      final SemaphoreElement? element = SemaphoreLanguage.semaphoreList.firstWhereOrNull((e) =>
      e.flagImageURL == flag &&
          ((semaphoreType == CurrentSemaphoreType.letter && e.filterType == FilterSemaphoreType.Letters) ||
              (semaphoreType == CurrentSemaphoreType.number && e.filterType == FilterSemaphoreType.Numbers))
      );

      if (element != null) {
        result += element.letter;
      }
    }

    return result.toLowerCase();
  }

  List<String> translateTextToSemaphore(String text) {
    CurrentSemaphoreType semaphoreType = CurrentSemaphoreType.letter;

    final Map<String, String?> semaphoreMap = {
      for (var element in SemaphoreLanguage.semaphoreList)
        element.letter.toUpperCase(): element.flagImageURL
    };

    final String formattedText = text
        .replaceAll(RegExp(r'[^a-zA-Z0-9čČšŠžŽ ]'), '')
        .replaceAll(RegExp(r' +'), ' ');

    List<String> result = [];

    for (var char in formattedText.toUpperCase().split('')) {
      if (RegExp(r'[a-zA-ZčČšŠžŽ]').hasMatch(char) && semaphoreType != CurrentSemaphoreType.letter) {
        semaphoreType = CurrentSemaphoreType.letter;
        result.add(semaphoreMap['{LETTERS TO FOLLOW}'] ?? '');
      } else if (RegExp(r'[0-9]').hasMatch(char) && semaphoreType != CurrentSemaphoreType.number) {
        semaphoreType = CurrentSemaphoreType.number;
        result.add(semaphoreMap['{NUMBERS TO FOLLOW}'] ?? '');
      }

      result.add(semaphoreMap[char] ?? '');
    }

    return result;
  }

}