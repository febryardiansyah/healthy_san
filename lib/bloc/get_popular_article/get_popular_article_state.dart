part of 'get_popular_article_cubit.dart';

@immutable
abstract class GetPopularArticleState {}

class GetPopularArticleInitial extends GetPopularArticleState {}
class GetPopularArticleLoading extends GetPopularArticleState {}
class GetPopularArticleSuccess extends GetPopularArticleState {
  final List<ArticleModel> data;

  GetPopularArticleSuccess(this.data);
}
class GetPopularArticleFailure extends GetPopularArticleState {
  final String msg;

  GetPopularArticleFailure(this.msg);
}
