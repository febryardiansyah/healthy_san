import 'package:bloc/bloc.dart';
import 'package:healthy_san/models/article_model.dart';
import 'package:healthy_san/repositories/article_repo.dart';
import 'package:meta/meta.dart';

part 'get_detail_article_state.dart';

class GetDetailArticleCubit extends Cubit<GetDetailArticleState> {
  GetDetailArticleCubit() : super(GetDetailArticleInitial());
  final _repo = ArticleRepo();

  void fetchArticles(String id)async{
    emit(GetDetailArticleLoading());
    try{
      final data = await _repo.getDetailArticle(id);
      emit(GetDetailArticleSuccess(data));
    }catch(e){
      emit(GetDetailArticleFailure(e.toString()));
    }
  }
}
