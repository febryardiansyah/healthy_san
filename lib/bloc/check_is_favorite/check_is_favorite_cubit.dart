import 'package:bloc/bloc.dart';
import 'package:healthy_san/repositories/article_repo.dart';
import 'package:meta/meta.dart';

import '../../models/article_model.dart';

part 'check_is_favorite_state.dart';

class CheckIsFavoriteCubit extends Cubit<CheckIsFavoriteState> {
  CheckIsFavoriteCubit() : super(CheckIsFavoriteInitial());
  final _repo = ArticleRepo();

  void isFavorite(ArticleModel article)async{
    emit(CheckIsFavoriteLoading());
    try{
      final data = await _repo.isFavorite(article);
      emit(CheckIsFavoriteSuccess(data));
    }catch(e){
      print('IS FAV FAILURE ==> $e');
      emit(CheckIsFavoriteFailure(e.toString()));
    }
  }
}
