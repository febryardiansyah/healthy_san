import 'package:bloc/bloc.dart';
import 'package:healthy_san/repositories/user_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'save_image_profile_state.dart';

class SaveImageProfileCubit extends Cubit<SaveImageProfileState> {
  SaveImageProfileCubit() : super(SaveImageProfileInitial());
  final _repo = UserRepo();

  void saveImage(XFile image)async{
    emit(SaveImageProfileLoading());
    try{
      await _repo.saveImageProfile(image);
      emit(SaveImageProfileSuccess('Foto profil berhasil disimpan!'));
    }catch(e){
      print(e);
      emit(SaveImageProfileFailure(e.toString()));
    }
  }
}
