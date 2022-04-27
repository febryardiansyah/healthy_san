part of 'get_detail_post_cubit.dart';

@immutable
abstract class GetDetailPostState {}

class GetDetailPostInitial extends GetDetailPostState {}
class GetDetailPostLoading extends GetDetailPostState {}
class GetDetailPostSuccess extends GetDetailPostState {
  final ForumDataModel data;

  GetDetailPostSuccess(this.data);
}
class GetDetailPostFailure extends GetDetailPostState {
  final String msg;

  GetDetailPostFailure(this.msg);
}
