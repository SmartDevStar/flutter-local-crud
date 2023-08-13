import 'package:dartz/dartz.dart';
import 'package:flutter_movie_star/core/exception.dart';
import 'package:flutter_movie_star/core/failure.dart';
import 'package:flutter_movie_star/features/user/data/datasources/user_local_datasource.dart';
import 'package:flutter_movie_star/features/user/domain/entities/user.dart';
import 'package:flutter_movie_star/features/user/domain/repositories/user_repository.dart';

import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource userLocalDataSource;

  UserRepositoryImpl({required this.userLocalDataSource});

  @override
  Future<Either<Failure, User>> addUser({required User user}) async {
    try {
      UserModel userModel =
          UserModel(username: user.username, email: user.email, uid: user.uid);
      final result = await userLocalDataSource.addUser(userModel: userModel);
      final addedUser = result.toUser;
      return Right(addedUser);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void deleteUser({required String uid}) async {
    try {
      userLocalDataSource.deleteUser(uid: uid);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final userModels = await userLocalDataSource.getUsers();
      final users = userModels.map((userModel) => userModel.toUser).toList();
      return Right(users);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser({required User newUser}) async {
    try {
      UserModel updatedUserModel = UserModel(
          username: newUser.username, email: newUser.email, uid: newUser.uid);
      final userModel = await userLocalDataSource.updateUser(
          updatedUserModel: updatedUserModel);
      final user = userModel.toUser;
      return Right(user);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
