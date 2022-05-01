part of 'get_new_article_cubit.dart';

@immutable
abstract class GetNewArticleState {}

class GetNewArticleInitial extends GetNewArticleState {}
class GetNewArticleLoading extends GetNewArticleState {}
class GetNewArticleSuccess extends GetNewArticleState {
  final List<ArticleModel> data;

  GetNewArticleSuccess(this.data);
}
class GetNewArticleFailure extends GetNewArticleState {
  final String msg;

  GetNewArticleFailure(this.msg);
}
