part of 'add_to_favorite_cubit.dart';

@immutable
abstract class AddToFavoriteState {}

class AddToFavoriteInitial extends AddToFavoriteState {}
class AddToFavoriteLoading extends AddToFavoriteState {}
class AddToFavoriteSuccess extends AddToFavoriteState {
  final String msg;

  AddToFavoriteSuccess(this.msg);
}
class AddToFavoriteFailure extends AddToFavoriteState {
  final String msg;

  AddToFavoriteFailure(this.msg);
}
