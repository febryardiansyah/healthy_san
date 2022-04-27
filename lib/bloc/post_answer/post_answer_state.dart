part of 'post_answer_cubit.dart';

@immutable
abstract class PostAnswerState {}

class PostAnswerInitial extends PostAnswerState {}
class PostAnswerLoading extends PostAnswerState {}
class PostAnswerSuccess extends PostAnswerState {
  final String msg;

  PostAnswerSuccess(this.msg);
}
class PostAnswerFailure extends PostAnswerState {
  final String msg;

  PostAnswerFailure(this.msg);
}
