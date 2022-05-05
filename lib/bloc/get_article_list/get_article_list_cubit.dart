import 'package:bloc/bloc.dart';
import 'package:healthy_san/repositories/article_repo.dart';
import 'package:meta/meta.dart';

import '../../models/article_model.dart';

part 'get_article_list_state.dart';

class GetArticleListCubit extends Cubit<GetArticleListState> {
  GetArticleListCubit() : super(GetArticleListInitial());
  final _repo = ArticleRepo();

  void fetchArticles({bool isPopular = false,String? keyword})async{
    emit(GetArticleListLoading());
    try{
      final data = await _repo.getArticle(isPopular: isPopular,keyword: keyword);
      print(data);
      emit(GetArticleListSuccess(data));
    }catch(e){
      print(e);
      emit(GetArticleListFailure(e.toString()));
    }
  }
}
