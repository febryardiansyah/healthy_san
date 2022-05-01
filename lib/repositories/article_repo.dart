import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_san/models/article_model.dart';

class ArticleRepo {
  final _fireStore = FirebaseFirestore.instance;

  Future<List<ArticleModel>> getArticle({bool isPopular = false,String? keyword})async{
    try{
      final res = await _fireStore.collection('articles')
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
      print(id);
      final res = await _fireStore.collection('articles').doc(id).get();
      print(res.data());
      final data = ArticleModel.fromMap(res.data()!);
      return data;
    }on FirebaseException catch(e){
      throw e.message ?? 'Something wrong!';
    }
  }
}