import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_san/models/forum_model.dart';
import 'package:healthy_san/models/user_model.dart';
import 'package:healthy_san/repositories/user_repo.dart';

class ForumRepo {
  final _fireStore = FirebaseFirestore.instance;
  final _userRepo = UserRepo();

  Future<void> postQuestion({String? question})async{
    try{
      final user = await _userRepo.getProfile();
      String id = _fireStore.collection('forums').doc().id;
      final forumData = ForumModel(
        id: id,
        answerIds: <String>[],
        question: question,
        postedBy: user.uid,
        createdAt: DateTime.now(),
      );
      await _fireStore.collection('forums').doc(id).set(forumData.toMap());
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }
  }

  Future<List<ForumDataModel>> getAllForum({bool isMyPost = false})async{
    try{
      final user = await _userRepo.getProfile();
      var res;
      if (isMyPost) {
        res = await _fireStore.collection('forums')
            .orderBy('createdAt',descending: true)
            .where('postedBy',isEqualTo: user.uid)
            .get();
      }else{
        res = await _fireStore.collection('forums')
            .orderBy('createdAt',descending: true)
            .get();
      }
      final data = List<ForumModel>.from(res.docs.map((e) => ForumModel.fromMap(e.data())));
      List<ForumDataModel> posts = [];
      for(var i in data){
        final userRes = await _fireStore.collection('users').doc(i.postedBy).get();
        final userData = UserModel.fromMap(userRes.data()!);
        posts.add(ForumDataModel(
          user: userData,
          post: i,
        ));
      }
      return posts;
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }
  }

  Future<void> deletePost(String id)async{
    try{
      await _fireStore.collection('forums').doc(id).delete();
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }
  }
}