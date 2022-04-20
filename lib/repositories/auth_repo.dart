import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthy_san/models/user_model.dart';
import 'package:healthy_san/utils/base_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> register({required String email,required String password,required String name})async{
    try{
      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final userData = UserModel(
        uid: user.user?.uid,email: email,name: name,
        profilePic: 'https://firebasestorage.googleapis.com/v0/b/healthy-san.appspot.com/o/no_avatar.png?alt=media&token=9eb952b4-bcc2-4b39-b5c5-3abcba2acede',
      );
      await _fireStore.collection('users').doc(user.user?.uid).set(userData.toMap());
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }catch(e){
      throw e;
    }
  }

  Future<void> login({required String email,required String password})async{
    try{
      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _saveToken(user.user!.uid);
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }catch(e){
      throw e;
    }
  }

  Future<void> _saveToken(String token)async{
    final pref = await SharedPreferences.getInstance();
    await pref.setString(BaseString.keyToken, token);
  }

  Future<String?> getToken()async{
    final pref = await SharedPreferences.getInstance();
    return await pref.getString(BaseString.keyToken);
  }

  Future<bool> hasToken()async{
    String? token = await getToken();
    return token != null;
  }
}