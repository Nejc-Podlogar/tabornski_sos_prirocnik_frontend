import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/post_api_service.dart';
import '../../models/post.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostApiService postApiService;


  PostCubit(this.postApiService) : super(PostInitial());

  Future<void> getLatestPost() async {
    emit(PostLoading());
    try {
      final Post post = await postApiService.getLatestPost();
      emit(PostSuccess(post: post));
    } catch (e) {
      emit(PostFailure(errorMessage: e.toString()));
    }
  }

}
