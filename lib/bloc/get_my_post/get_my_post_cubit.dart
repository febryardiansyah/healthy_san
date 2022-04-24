import 'package:bloc/bloc.dart';
import 'package:healthy_san/models/forum_model.dart';
import 'package:healthy_san/repositories/forum_repo.dart';
import 'package:meta/meta.dart';

part 'get_my_post_state.dart';

class GetMyPostCubit extends Cubit<GetMyPostState> {
  GetMyPostCubit() : super(GetMyPostInitial());
  final _repo = ForumRepo();

  void fetchMyPost()async{
    emit(GetMyPostLoading());
    try{
      final res = await _repo.getAllForum(isMyPost: true);
      emit(GetMyPostSuccess(res));
    }catch(e){
      emit(GetMyPostFailure(e.toString()));
    }
  }
}
