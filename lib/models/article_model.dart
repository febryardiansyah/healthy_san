class ArticleModel{
  final String? title;
  final String? imageUrl;
  final String? desc;
  final bool? isPopular;
  final String? id;

  ArticleModel({this.title, this.imageUrl, this.desc,this.isPopular,this.id});

  factory ArticleModel.fromMap(Map<String,dynamic>json)=>ArticleModel(
    id: json['id'],
    title: json['title'],
    imageUrl: json['imageUrl'],
    desc: json['desc'],
    isPopular: json['isPopular'],
  );

  Map<String,dynamic> toMap()=>{
    'id':id,'title':title,'imageUrl':imageUrl,
    'desc':desc,'isPopular':isPopular,
  };
}