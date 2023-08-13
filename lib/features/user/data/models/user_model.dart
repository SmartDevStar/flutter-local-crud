import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:flutter_movie_star/features/user/domain/entities/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends Equatable {
  const UserModel({
    required this.username,
    required this.email,
    required this.uid,
  });

  @HiveField(0)
  final String username;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String uid;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json['username'],
        email: json['email'],
        uid: json['uid'],
      );

  User get toUser => User(
        username: username,
        email: email,
        uid: uid,
      );

  @override
  List<Object?> get props => [username, email, uid];
}
