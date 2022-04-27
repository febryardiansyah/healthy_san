part of 'get_answers_cubit.dart';

@immutable
abstract class GetAnswersState {}

class GetAnswersInitial extends GetAnswersState {}
class GetAnswersLoading extends GetAnswersState {}
class GetAnswersSuccess extends GetAnswersState {
  final List<AnswerDataModel> data;

  GetAnswersSuccess(this.data);
}
class GetAnswersFailure extends GetAnswersState {
  final String msg;

  GetAnswersFailure(this.msg);
}
