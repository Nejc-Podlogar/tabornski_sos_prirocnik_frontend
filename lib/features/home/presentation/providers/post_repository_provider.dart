import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/repositories/post_repository.dart';
import '../../domain/repositories/i_post_repository.dart';

final postRepositoryProvider = Provider<IPostRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return PostRepository(db);
});
