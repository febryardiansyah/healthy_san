class UserModel{
  final String? uid;
  final String? name;
  final String? email;
  final String? profilePic;

  UserModel({this.name, this.email, this.profilePic,this.uid});

  factory UserModel.fromMap(Map<String,dynamic>json)=>UserModel(
    name: json['name'],email: json['email'],profilePic: json['profilePic'],
    uid: json['uid'],
  );

  Map<String,dynamic> toMap()=> {
    'name':name,'email':email,'profilePic':profilePic,
    'uid':uid,
  };
}