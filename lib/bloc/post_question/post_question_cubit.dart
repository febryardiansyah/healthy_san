import 'package:bloc/bloc.dart';
import 'package:healthy_san/repositories/forum_repo.dart';
import 'package:meta/meta.dart';

part 'post_question_state.dart';

class PostQuestionCubit extends Cubit<PostQuestionState> {
  PostQuestionCubit() : super(PostQuestionInitial());
  final _repo = ForumRepo();

  void postQuestion({String? question})async {
    emit(PostQuestionLoading());
    try {
      await _repo.postQuestion(question: question);
      emit(PostQuestionSuccess('Berhasil!!'));
    } catch (e) {
      print(e);
      emit(PostQuestionFailure(e.toString()));
    }
  }
}
