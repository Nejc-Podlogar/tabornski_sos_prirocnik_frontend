class ExerciseSessionFormatter {
  ExerciseSessionFormatter._();

  static double percentage(int correct, int total) {
    if (total == 0) return 0.0;
    return correct / total;
  }

  static String badgeLabel(double percentage) {
    if (percentage >= 0.8) return 'ODLIČNO';
    if (percentage >= 0.5) return 'DOBRO';
    return 'POSKUSI ZNOVA';
  }

  static String formatDate(DateTime date) {
    final local = date.toLocal();
    final d = local.day.toString().padLeft(2, '0');
    final m = local.month.toString().padLeft(2, '0');
    final y = local.year;
    final h = local.hour.toString().padLeft(2, '0');
    final min = local.minute.toString().padLeft(2, '0');
    return '$d. $m. $y  $h:$min';
  }

  static String formatDuration(int seconds) {
    if (seconds < 60) return '${seconds}s';
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return s == 0 ? '${m}min' : '${m}min ${s}s';
  }
}
