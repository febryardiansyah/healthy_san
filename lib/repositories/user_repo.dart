import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:healthy_san/models/user_model.dart';
import 'package:healthy_san/repositories/auth_repo.dart';
import 'package:image_picker/image_picker.dart';

class UserRepo {
  final _fireStore = FirebaseFirestore.instance;
  final _authRepo = AuthRepo();
  final _storage = FirebaseStorage.instance;

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

  Future<void> saveImageProfile(XFile image)async{
    try{
      String? token = await _authRepo.getToken();
      final ref = await _storage.ref('uploads/${image.name}').putFile(File(image.path));
      String url = await ref.ref.getDownloadURL();
      await _fireStore.collection('users').doc(token).update({
        'profilePic':url
      });
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }
  }

}