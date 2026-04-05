import '../entities/post.dart';
import '../repositories/i_post_repository.dart';

class FetchAndCachePostUseCase {
  const FetchAndCachePostUseCase(this._repository);

  final IPostRepository _repository;

  Future<Post?> call() async {
    try {
      final remote = await _repository.fetchRemote();
      if (remote != null) {
        await _repository.cache(remote);
        return remote;
      }
      return _repository.getCached();
    } catch (_) {
      return _repository.getCached();
    }
  }
}
