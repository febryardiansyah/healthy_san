import 'package:bloc/bloc.dart';
import 'package:healthy_san/repositories/user_repo.dart';
import 'package:meta/meta.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());
  final _repo = UserRepo();

  void updateProfile({String? name,String? oldPassword,String? newPassword})async{
    emit(UpdateProfileLoading());
    try{
      await _repo.updateProfile(name: name,oldPassword: oldPassword,newPassword: newPassword);
      emit(UpdateProfileSuccess('Profil berhasil diubah!'));
    }catch(e){
      print(e);
      emit(UpdateProfileFailure(e.toString()));
    }
  }
}
