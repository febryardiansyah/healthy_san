part of 'save_image_profile_cubit.dart';

@immutable
abstract class SaveImageProfileState {}

class SaveImageProfileInitial extends SaveImageProfileState {}
class SaveImageProfileLoading extends SaveImageProfileState {}
class SaveImageProfileSuccess extends SaveImageProfileState {
  final String msg;

  SaveImageProfileSuccess(this.msg);
}
class SaveImageProfileFailure extends SaveImageProfileState {
  final String msg;

  SaveImageProfileFailure(this.msg);
}
