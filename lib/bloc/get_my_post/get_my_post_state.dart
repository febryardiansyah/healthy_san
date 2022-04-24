part of 'get_my_post_cubit.dart';

@immutable
abstract class GetMyPostState {}

class GetMyPostInitial extends GetMyPostState {}
class GetMyPostLoading extends GetMyPostState {}
class GetMyPostSuccess extends GetMyPostState {
  final List<ForumDataModel> data;

  GetMyPostSuccess(this.data);
}
class GetMyPostFailure extends GetMyPostState {
  final String msg;

  GetMyPostFailure(this.msg);
}
