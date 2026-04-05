import '../entities/post.dart';
import '../repositories/i_post_repository.dart';

class GetLatestPostUseCase {
  const GetLatestPostUseCase(this._repository);

  final IPostRepository _repository;

  Future<Post?> call() => _repository.getCached();
}
