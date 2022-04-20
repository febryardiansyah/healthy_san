import 'package:bloc/bloc.dart';
import 'package:healthy_san/repositories/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final _repo = AuthRepo();

  void checkLogin()async{
    bool hasToken = await _repo.hasToken();
    if (hasToken) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnAuthenticated());
    }
  }

  void loggedIn()async=>emit(AuthAuthenticated());
  void loggedOut()async=>emit(AuthUnAuthenticated());
}
