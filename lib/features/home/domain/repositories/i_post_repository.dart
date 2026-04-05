import '../entities/post.dart';

abstract interface class IPostRepository {
  Future<Post?> getCached();
  Future<Post?> fetchRemote();
  Future<void> cache(Post post);
}
