import 'package:bloc/bloc.dart';
import 'package:healthy_san/models/user_model.dart';
import 'package:healthy_san/repositories/user_repo.dart';
import 'package:meta/meta.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit() : super(GetProfileInitial());
  final _repo = UserRepo();

  void fetchProfile()async{
    emit(GetProfileLoading());
    try{
      final res = await _repo.getProfile();
      emit(GetProfileSuccess(res));
    }catch(e){
      emit(GetProfileFailure(e.toString()));
    }
  }
}
