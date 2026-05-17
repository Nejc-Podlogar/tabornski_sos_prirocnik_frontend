import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../exercise_history/presentation/providers/exercise_history_repository_provider.dart';
import '../../domain/usecases/save_morse_session_usecase.dart';

final saveMorseSessionUseCaseProvider = Provider<SaveMorseSessionUseCase>((ref) {
  return SaveMorseSessionUseCase(ref.watch(exerciseHistoryRepositoryProvider));
});
