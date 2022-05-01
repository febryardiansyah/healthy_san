import 'package:bloc/bloc.dart';
import 'package:healthy_san/models/article_model.dart';
import 'package:healthy_san/repositories/article_repo.dart';
import 'package:meta/meta.dart';

part 'get_new_article_state.dart';

class GetNewArticleCubit extends Cubit<GetNewArticleState> {
  GetNewArticleCubit() : super(GetNewArticleInitial());
  final _repo = ArticleRepo();

  void fetchArticles()async{
    emit(GetNewArticleLoading());
    try{
      final data = await _repo.getArticle();
      emit(GetNewArticleSuccess(data));
    }catch(e){
      emit(GetNewArticleFailure(e.toString()));
    }
  }
}
