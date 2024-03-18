import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User{
  @HiveField(0)
  String username;
  @HiveField(1)
   String  email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  String? key;
  @HiveField(4)
  String? profilepicPath;
  

  User({this.key,required this.username, required this.email, required this.password,this.profilepicPath,});

}