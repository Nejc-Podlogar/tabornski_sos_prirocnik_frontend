part of 'post_cubit.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}
class PostLoading extends PostState {}

class PostSuccess extends PostState {
  final Post post;

  PostSuccess({required this.post});
}

class PostFailure extends PostState {
  final String errorMessage;

  PostFailure({required this.errorMessage});
}
