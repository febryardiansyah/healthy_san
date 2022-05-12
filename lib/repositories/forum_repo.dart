import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
        totalAnswer: 0,
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
      var res;
      if (isMyPost) {
        final user = await _userRepo.getProfile();
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
      await _fireStore.collection('forums').doc(id).collection('answers').doc().delete();
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }
  }

  Future<ForumDataModel> getDetailPost(String id)async{
    try{
      final forumRef = await _fireStore.collection('forums').doc(id).get();
      final forumData = ForumModel.fromMap(forumRef.data()!);
      final userRef = await _fireStore.collection('users').doc(forumData.postedBy).get();
      final userData = UserModel.fromMap(userRef.data()!);
      return ForumDataModel(
        user: userData,
        post: forumData,
      );
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }
  }

  Future<void> postAnswer(String postId,String answer)async{
    try{
      final user = await _userRepo.getProfile();
      final id = await _fireStore.collection('forums').doc(postId).collection('answers').doc().id;
      final answerData = AnswerModel(
        id: id,answer: answer,
        commentedBy: user.uid,
        createdAt: DateTime.now(),
      );
      await _fireStore.collection('forums').doc(postId).collection('answers').doc(id).set(answerData.toMap());
      final answerRef = await _fireStore.collection('forums').doc(postId).collection('answers').get();
      final parsedAnswer = List<AnswerModel>.from(answerRef.docs.map((e) => AnswerModel.fromMap(e.data())));
      await _fireStore.collection('forums').doc(postId).update({
        'totalAnswer':parsedAnswer.length,
      });
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }
  }

  Future<List<AnswerDataModel>> getAnswerList(String postId)async{
    try{
      final answerRef = await _fireStore.collection('forums').doc(postId).collection('answers')
          .orderBy('createdAt',descending: true).get();
      final answerData = List<AnswerModel>.from(answerRef.docs.map((e) => AnswerModel.fromMap(e.data())));
      List<AnswerDataModel> answers = [];
      for(var i in answerData){
        final userRes = await _fireStore.collection('users').doc(i.commentedBy).get();
        final userData = UserModel.fromMap(userRes.data()!);
        answers.add(AnswerDataModel(userData, i));
      }
      return answers;
    }on FirebaseException catch(e){
      throw e.message ?? 'Something Wrong!';
    }
  }
}