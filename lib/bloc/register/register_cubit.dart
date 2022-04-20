import 'package:bloc/bloc.dart';
import 'package:healthy_san/repositories/auth_repo.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final _repo = AuthRepo();

  Future<void> register({required String email,required String password,required String name})async{
    emit(RegisterLoading());
    try{
      await _repo.register(email: email, password: password, name: name);
      emit(RegisterSuccess('Berhasil!'));
    }catch(e){
      print(e);
      emit(RegisterFailure(e.toString()));
    }
  }
}
