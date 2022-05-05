import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_san/models/article_model.dart';
import 'package:healthy_san/repositories/user_repo.dart';

class ArticleRepo {
  final _fireStore = FirebaseFirestore.instance;
  final _userRepo = UserRepo();

  Future<List<ArticleModel>> getArticle({bool isPopular = false,String? keyword})async{
    String? _keyword = keyword == null?null:keyword.length == 0?null:keyword[0].toUpperCase()+keyword.substring(1).toLowerCase();
    try{
      final res = await _fireStore.collection('articles')
          .where('title',isGreaterThanOrEqualTo: _keyword)
          .where('isPopular',isEqualTo: isPopular)
          .get();
      final data = List<ArticleModel>.from(res.docs.map((e) => ArticleModel.fromMap(e.data())));
      return data;
    }on FirebaseException catch(e){
      throw e.message ?? 'Something Wrong!';
    }
  }

  Future<ArticleModel> getDetailArticle(String id)async{
    try{
      final res = await _fireStore.collection('articles').doc(id).get();
      final data = ArticleModel.fromMap(res.data()!);
      return data;
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }
  }

  Future<void> addToFavorite(ArticleModel article,bool isFav)async{
    try{
      final user = await _userRepo.getProfile();
      if (isFav) {
        await _fireStore.collection('users').doc(user.uid).collection('favorites').doc(article.id).delete();
        print('Removed');
      } else {
        await _fireStore.collection('users').doc(user.uid).collection('favorites').doc(article.id).set(article.toMap());
        print('Added');
      }
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }
  }

  Future<bool> isFavorite(ArticleModel article)async{
    try{
      final user = await _userRepo.getProfile();
      final res = await _fireStore.collection('users').doc(user.uid).collection('favorites').doc(article.id).get();
      return res.exists;
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }
  }

  Future<List<ArticleModel>> getFavorite(String uid)async{
    try{
      final res = await _fireStore.collection('users').doc(uid).collection('favorites').get();
      final data = List<ArticleModel>.from(res.docs.map((e) => ArticleModel.fromMap(e.data())));
      return data;
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }
  }
}