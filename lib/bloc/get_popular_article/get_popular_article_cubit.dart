import 'package:bloc/bloc.dart';
import 'package:healthy_san/models/article_model.dart';
import 'package:healthy_san/repositories/article_repo.dart';
import 'package:meta/meta.dart';

part 'get_popular_article_state.dart';

class GetPopularArticleCubit extends Cubit<GetPopularArticleState> {
  GetPopularArticleCubit() : super(GetPopularArticleInitial());
  final _repo = ArticleRepo();

  void fetchArticles()async{
    emit(GetPopularArticleLoading());
    try{
      final res = await _repo.getArticle(isPopular: true);
      emit(GetPopularArticleSuccess(res));
    }catch(e){
      emit(GetPopularArticleFailure(e.toString()));
    }
  }
}
