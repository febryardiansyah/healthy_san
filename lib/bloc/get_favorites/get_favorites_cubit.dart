import 'package:bloc/bloc.dart';
import 'package:healthy_san/models/article_model.dart';
import 'package:healthy_san/repositories/article_repo.dart';
import 'package:meta/meta.dart';

part 'get_favorites_state.dart';

class GetFavoritesCubit extends Cubit<GetFavoritesState> {
  GetFavoritesCubit() : super(GetFavoritesInitial());
  final _repo = ArticleRepo();

  void fetchFavorites(String uid)async{
    emit(GetFavoritesLoading());
    try{
      final data = await _repo.getFavorite(uid);
      emit(GetFavoritesSuccess(data));
    }catch(e){
      emit(GetFavoritesFailure(e.toString()));
    }
  }
}
