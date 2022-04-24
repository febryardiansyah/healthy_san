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
  final List<String>? answerIds;
  final DateTime? createdAt;

  ForumModel({this.id, this.postedBy, this.question, this.answerIds, this.createdAt,});

  factory ForumModel.fromMap(Map<String,dynamic>json)=>ForumModel(
    id: json['id'],
    postedBy: json['postedBy'],
    question: json['question'],
    answerIds: List<String>.from(json['answerIds'].map((x)=>x)),
    createdAt: DateTime.parse(json['createdAt']),
  );

  Map<String,dynamic> toMap()=>{
    'id':id,
    'postedBy':postedBy,
    'question':question,
    'answerIds':answerIds,
    'createdAt':createdAt?.toIso8601String(),
  };
}

class AnswerModel{
  final String? id;
  final String? commentBy;
  final String? answer;

  AnswerModel({this.id, this.commentBy, this.answer});
}