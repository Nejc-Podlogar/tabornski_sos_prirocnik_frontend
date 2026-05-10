// TODO: Add actual flag image assets to assets/images/semaphore/flags/
// before shipping. Paths below are placeholders — one PNG per letter.

/// Maps each character to its semaphore flag image asset path.
class SemaphoreDictionary {
  SemaphoreDictionary._();

  static const Map<String, String> charToImage = {
    'A': 'assets/images/semaphore/flags/a.png',
    'B': 'assets/images/semaphore/flags/b.png',
    'C': 'assets/images/semaphore/flags/c.png',
    'D': 'assets/images/semaphore/flags/d.png',
    'E': 'assets/images/semaphore/flags/e.png',
    'F': 'assets/images/semaphore/flags/f.png',
    'G': 'assets/images/semaphore/flags/g.png',
    'H': 'assets/images/semaphore/flags/h.png',
    'I': 'assets/images/semaphore/flags/i.png',
    'J': 'assets/images/semaphore/flags/j.png',
    'K': 'assets/images/semaphore/flags/k.png',
    'L': 'assets/images/semaphore/flags/l.png',
    'M': 'assets/images/semaphore/flags/m.png',
    'N': 'assets/images/semaphore/flags/n.png',
    'O': 'assets/images/semaphore/flags/o.png',
    'P': 'assets/images/semaphore/flags/p.png',
    'Q': 'assets/images/semaphore/flags/q.png',
    'R': 'assets/images/semaphore/flags/r.png',
    'S': 'assets/images/semaphore/flags/s.png',
    'T': 'assets/images/semaphore/flags/t.png',
    'U': 'assets/images/semaphore/flags/u.png',
    'V': 'assets/images/semaphore/flags/v.png',
    'W': 'assets/images/semaphore/flags/w.png',
    'X': 'assets/images/semaphore/flags/x.png',
    'Y': 'assets/images/semaphore/flags/y.png',
    'Z': 'assets/images/semaphore/flags/z.png',
    // Slovenian characters
    'Š': 'assets/images/semaphore/flags/s_caron.png',
    'Č': 'assets/images/semaphore/flags/c_caron.png',
    'Ž': 'assets/images/semaphore/flags/z_caron.png',
    // Special
    ' ': 'assets/images/semaphore/flags/space.png',
  };

  /// Reverse map: image path → character.
  static final Map<String, String> imageToChar = {
    for (final e in charToImage.entries) e.value: e.key,
  };
}
