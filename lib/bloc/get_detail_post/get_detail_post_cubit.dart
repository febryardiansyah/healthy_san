import 'package:bloc/bloc.dart';
import 'package:healthy_san/models/forum_model.dart';
import 'package:healthy_san/repositories/forum_repo.dart';
import 'package:meta/meta.dart';

part 'get_detail_post_state.dart';

class GetDetailPostCubit extends Cubit<GetDetailPostState> {
  GetDetailPostCubit() : super(GetDetailPostInitial());
  final _repo = ForumRepo();

  void fetchDetailPost(String id)async{
    emit(GetDetailPostLoading());
    try{
      final data = await _repo.getDetailPost(id);
      emit(GetDetailPostSuccess(data));
    }catch(e){
      emit(GetDetailPostFailure(e.toString()));
    }
  }
}
