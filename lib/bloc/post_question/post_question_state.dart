part of 'post_question_cubit.dart';

@immutable
abstract class PostQuestionState {}

class PostQuestionInitial extends PostQuestionState {}
class PostQuestionLoading extends PostQuestionState {}
class PostQuestionSuccess extends PostQuestionState {
  final String msg;

  PostQuestionSuccess(this.msg);
}
class PostQuestionFailure extends PostQuestionState {
  final String msg;

  PostQuestionFailure(this.msg);
}
