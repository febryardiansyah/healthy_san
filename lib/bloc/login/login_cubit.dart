import 'package:bloc/bloc.dart';
import 'package:healthy_san/repositories/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final _repo = AuthRepo();

  void login({required String email,required String password})async{
    try{
      await _repo.login(email: email, password: password);
      emit(LoginSuccess('Login berhasil!'));
    }catch(e){
      print(e);
      emit(LoginFailure(e.toString()));
    }
  }
}