part of 'get_article_list_cubit.dart';

@immutable
abstract class GetArticleListState {}

class GetArticleListInitial extends GetArticleListState {}
class GetArticleListLoading extends GetArticleListState {}
class GetArticleListSuccess extends GetArticleListState {
  final List<ArticleModel> data;

  GetArticleListSuccess(this.data);
}
class GetArticleListFailure extends GetArticleListState {
  final String msg;

  GetArticleListFailure(this.msg);
}
