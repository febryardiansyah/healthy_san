part of 'get_detail_article_cubit.dart';

@immutable
abstract class GetDetailArticleState {}

class GetDetailArticleInitial extends GetDetailArticleState {}
class GetDetailArticleLoading extends GetDetailArticleState {}
class GetDetailArticleSuccess extends GetDetailArticleState {
  final ArticleModel data;

  GetDetailArticleSuccess(this.data);
}
class GetDetailArticleFailure extends GetDetailArticleState {
  final String msg;

  GetDetailArticleFailure(this.msg);
}
