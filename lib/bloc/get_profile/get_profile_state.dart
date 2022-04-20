part of 'get_profile_cubit.dart';

@immutable
abstract class GetProfileState {}

class GetProfileInitial extends GetProfileState {}
class GetProfileLoading extends GetProfileState {}
class GetProfileSuccess extends GetProfileState {
  final UserModel user;

  GetProfileSuccess(this.user);
}
class GetProfileFailure extends GetProfileState {
  final String msg;

  GetProfileFailure(this.msg);
}
