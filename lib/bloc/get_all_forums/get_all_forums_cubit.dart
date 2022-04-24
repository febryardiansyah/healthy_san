import 'package:bloc/bloc.dart';
import 'package:healthy_san/models/forum_model.dart';
import 'package:healthy_san/repositories/forum_repo.dart';
import 'package:meta/meta.dart';

part 'get_all_forums_state.dart';

class GetAllForumsCubit extends Cubit<GetAllForumsState> {
  GetAllForumsCubit() : super(GetAllForumsInitial());
  final _repo = ForumRepo();

  void fetchAllForum()async{
    emit(GetAllForumsLoading());
    try{
      final _res = await _repo.getAllForum();
      emit(GetAllForumsSuccess(_res));
    }catch(e){
      print(e);
      emit(GetAllForumsFailure(e.toString()));
    }
  }
}
