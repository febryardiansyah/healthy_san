import 'package:healthy_san/models/user_model.dart';

class ForumDataModel{
  final UserModel? user;
  final ForumModel? post;

  ForumDataModel({this.user, this.post});
}

class ForumModel{
  final String? id;
  final String? postedBy;
  final String? question;
  final int? totalAnswer;
  final DateTime? createdAt;

  ForumModel({this.id, this.postedBy, this.question, this.totalAnswer, this.createdAt,});

  factory ForumModel.fromMap(Map<String,dynamic>json)=>ForumModel(
    id: json['id'],
    postedBy: json['postedBy'],
    question: json['question'],
    totalAnswer: json['totalAnswer'],
    createdAt: DateTime.parse(json['createdAt']),
  );

  Map<String,dynamic> toMap()=>{
    'id':id,
    'postedBy':postedBy,
    'question':question,
    'totalAnswer':totalAnswer,
    'createdAt':createdAt?.toIso8601String(),
  };
}

class AnswerDataModel{
  final UserModel user;
  final AnswerModel answer;

  AnswerDataModel(this.user, this.answer);
}

class AnswerModel{
  final String? id;
  final String? commentedBy;
  final String? answer;
  final DateTime? createdAt;

  AnswerModel({this.id, this.commentedBy, this.answer,this.createdAt});

  factory AnswerModel.fromMap(Map<String,dynamic>json){
    return AnswerModel(
      id: json['id'],
      commentedBy: json['commentedBy'],
      answer: json['answer'],
      createdAt: DateTime.parse(json['createdAt'])
    );
  }

  Map<String,dynamic> toMap()=>{
    'id':id,
    'commentedBy':commentedBy,
    'answer':answer,
    'createdAt':createdAt?.toIso8601String(),
  };
}