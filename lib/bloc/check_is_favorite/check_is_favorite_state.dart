part of 'check_is_favorite_cubit.dart';

@immutable
abstract class CheckIsFavoriteState {}

class CheckIsFavoriteInitial extends CheckIsFavoriteState {}
class CheckIsFavoriteLoading extends CheckIsFavoriteState {}
class CheckIsFavoriteSuccess extends CheckIsFavoriteState {
  final bool value;

  CheckIsFavoriteSuccess(this.value);
}
class CheckIsFavoriteFailure extends CheckIsFavoriteState {
  final String msg;

  CheckIsFavoriteFailure(this.msg);
}
