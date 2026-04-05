import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/post.dart';
import '../../domain/usecases/fetch_and_cache_post_usecase.dart';
import 'post_repository_provider.dart';

final postProvider = AsyncNotifierProvider<PostNotifier, Post?>(
  PostNotifier.new,
);

class PostNotifier extends AsyncNotifier<Post?> {
  @override
  Future<Post?> build() async {
    final repo = ref.read(postRepositoryProvider);
    final useCase = FetchAndCachePostUseCase(repo);
    return useCase.call();
  }
}
