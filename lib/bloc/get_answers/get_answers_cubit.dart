import 'package:bloc/bloc.dart';
import 'package:healthy_san/models/forum_model.dart';
import 'package:healthy_san/repositories/forum_repo.dart';
import 'package:meta/meta.dart';

part 'get_answers_state.dart';

class GetAnswersCubit extends Cubit<GetAnswersState> {
  GetAnswersCubit() : super(GetAnswersInitial());
  final _repo = ForumRepo();

  void fetchAnswers(String postId)async{
    emit(GetAnswersLoading());
    try{
      final data = await _repo.getAnswerList(postId);
      emit(GetAnswersSuccess(data));
    }catch(e){
      emit(GetAnswersFailure(e.toString()));
    }
  }
}
