import 'package:bloc/bloc.dart';
import 'package:healthy_san/repositories/forum_repo.dart';
import 'package:meta/meta.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit() : super(DeletePostInitial());
  final _repo = ForumRepo();

  void delete(String id)async{
    emit(DeletePostLoading());
    try{
      print(id);
      await _repo.deletePost(id);
      emit(DeletePostSuccess('Berhasil menghapus!!'));
    }catch(e){
      emit(DeletePostFailure(e.toString()));
    }
  }
}
