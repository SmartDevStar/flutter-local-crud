import 'package:dartz/dartz.dart';
import 'package:flutter_movie_star/core/failure.dart';

import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UserUsecase implements UserRepository {
  final UserRepository userRepository;

  UserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, User>> addUser({required User user}) async {
    return await userRepository.addUser(user: user);
  }

  @override
  void deleteUser({required String uid}) async {
    userRepository.deleteUser(uid: uid);
  }

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    return await userRepository.getUsers();
  }

  @override
  Future<Either<Failure, User>> updateUser({required User newUser}) async {
    return await userRepository.updateUser(newUser: newUser);
  }
}
