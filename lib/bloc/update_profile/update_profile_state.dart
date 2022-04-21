part of 'update_profile_cubit.dart';

@immutable
abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}
class UpdateProfileLoading extends UpdateProfileState {}
class UpdateProfileSuccess extends UpdateProfileState {
  final String msg;

  UpdateProfileSuccess(this.msg);
}
class UpdateProfileFailure extends UpdateProfileState {
  final String msg;

  UpdateProfileFailure(this.msg);
}
