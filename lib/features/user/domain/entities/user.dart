import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.username,
    required this.email,
    required this.uid,
  });

  final String username;
  final String email;
  final String uid;

  @override
  List<Object?> get props => [username, email, uid];
}
