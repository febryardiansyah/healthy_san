import 'package:bloc/bloc.dart';
import 'package:healthy_san/repositories/forum_repo.dart';
import 'package:meta/meta.dart';

part 'post_answer_state.dart';

class PostAnswerCubit extends Cubit<PostAnswerState> {
  PostAnswerCubit() : super(PostAnswerInitial());
  final _repo = ForumRepo();

  void postAnswer(String postId,String answer)async{
    emit(PostAnswerLoading());
    try{
      await _repo.postAnswer(postId, answer);
      emit(PostAnswerSuccess('Berhasil!'));
    }catch(e){
      emit(PostAnswerFailure(e.toString()));
    }
  }
}
