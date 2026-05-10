import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/orientation_repository.dart';
import '../../domain/repositories/i_orientation_repository.dart';

final orientationRepositoryProvider = Provider<IOrientationRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return OrientationRepository(db);
});
