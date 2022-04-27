part of 'delete_post_cubit.dart';

@immutable
abstract class DeletePostState {}

class DeletePostInitial extends DeletePostState {}
class DeletePostLoading extends DeletePostState {}
class DeletePostSuccess extends DeletePostState {
  final String msg;

  DeletePostSuccess(this.msg);
}
class DeletePostFailure extends DeletePostState {
  final String msg;

  DeletePostFailure(this.msg);
}
