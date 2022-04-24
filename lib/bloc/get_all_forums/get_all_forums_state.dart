part of 'get_all_forums_cubit.dart';

@immutable
abstract class GetAllForumsState {}

class GetAllForumsInitial extends GetAllForumsState {}
class GetAllForumsLoading extends GetAllForumsState {}
class GetAllForumsSuccess extends GetAllForumsState {
  final List<ForumDataModel> data;

  GetAllForumsSuccess(this.data);
}
class GetAllForumsFailure extends GetAllForumsState {
  final String msg;

  GetAllForumsFailure(this.msg);
}
