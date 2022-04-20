import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_san/models/user_model.dart';
import 'package:healthy_san/repositories/auth_repo.dart';

class UserRepo {
  final _fireStore = FirebaseFirestore.instance;
  final _authRepo = AuthRepo();

  Future<UserModel> getProfile()async{
    try{
      String? token = await _authRepo.getToken();
      final res = await _fireStore.collection('users').doc(token).get();
      return UserModel.fromMap(res.data()!);
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }catch(e){
      throw e;
    }
  }
}