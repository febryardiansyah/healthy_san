part of 'get_favorites_cubit.dart';

@immutable
abstract class GetFavoritesState {}

class GetFavoritesInitial extends GetFavoritesState {}
class GetFavoritesLoading extends GetFavoritesState {}
class GetFavoritesSuccess extends GetFavoritesState {
  final List<ArticleModel> data;

  GetFavoritesSuccess(this.data);
}
class GetFavoritesFailure extends GetFavoritesState {
  final String msg;

  GetFavoritesFailure(this.msg);
}
