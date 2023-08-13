import 'package:dartz/dartz.dart';
import 'package:flutter_movie_star/core/failure.dart';

import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, User>> addUser({required User user});
  Future<Either<Failure, User>> updateUser({required User newUser});
  void deleteUser({required String uid});
}
