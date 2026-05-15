/// Maps each character to its semaphore flag image asset path.
class SemaphoreDictionary {
  SemaphoreDictionary._();

  static const Map<String, String> charToImage = {
    'A': 'assets/images/semaphore/flags/A_1.png',
    'B': 'assets/images/semaphore/flags/B_2.png',
    'C': 'assets/images/semaphore/flags/C_3.png',
    'D': 'assets/images/semaphore/flags/D_4.png',
    'E': 'assets/images/semaphore/flags/E_5.png',
    'F': 'assets/images/semaphore/flags/F_6.png',
    'G': 'assets/images/semaphore/flags/G_7.png',
    'H': 'assets/images/semaphore/flags/H_8.png',
    'I': 'assets/images/semaphore/flags/I_9.png',
    'J': 'assets/images/semaphore/flags/J.png',
    'K': 'assets/images/semaphore/flags/K_0.png',
    'L': 'assets/images/semaphore/flags/L.png',
    'M': 'assets/images/semaphore/flags/M.png',
    'N': 'assets/images/semaphore/flags/N.png',
    'O': 'assets/images/semaphore/flags/O.png',
    'P': 'assets/images/semaphore/flags/P.png',
    'Q': 'assets/images/semaphore/flags/Q.png',
    'R': 'assets/images/semaphore/flags/R.png',
    'S': 'assets/images/semaphore/flags/S.png',
    'T': 'assets/images/semaphore/flags/T.png',
    'U': 'assets/images/semaphore/flags/U.png',
    'V': 'assets/images/semaphore/flags/V.png',
    'W': 'assets/images/semaphore/flags/W.png',
    'X': 'assets/images/semaphore/flags/X.png',
    'Y': 'assets/images/semaphore/flags/Y.png',
    'Z': 'assets/images/semaphore/flags/Z.png',
    ' ': 'assets/images/semaphore/flags/space.png',
  };

  /// Reverse map: image path → character.
  static final Map<String, String> imageToChar = {
    for (final e in charToImage.entries) e.value: e.key,
  };
}
