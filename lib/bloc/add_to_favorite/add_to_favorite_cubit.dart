import 'package:bloc/bloc.dart';
import 'package:healthy_san/repositories/article_repo.dart';
import 'package:meta/meta.dart';

import '../../models/article_model.dart';

part 'add_to_favorite_state.dart';

class AddToFavoriteCubit extends Cubit<AddToFavoriteState> {
  AddToFavoriteCubit() : super(AddToFavoriteInitial());
  final _repo = ArticleRepo();

  void addToFav(ArticleModel article,bool isFav)async{
    emit(AddToFavoriteLoading());
    try{
      await _repo.addToFavorite(article,isFav);
      if (isFav) {
        emit(AddToFavoriteSuccess('Berhasil dihapus dari Favorite'));
      } else {
        emit(AddToFavoriteSuccess('Berhasil ditambahkan ke Favorite'));
      }
    }catch(e){
      emit(AddToFavoriteFailure(e.toString()));
    }
  }
}
