import 'package:flutter_movie_star/core/exception.dart';

import 'user_hive_helper.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> addUser({required UserModel userModel});
  Future<UserModel> updateUser({required UserModel updatedUserModel});
  void deleteUser({required String uid});
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final UserHiveHelper userHiveHelper;

  UserLocalDataSourceImpl({required this.userHiveHelper});

  @override
  Future<UserModel> addUser({required UserModel userModel}) async {
    final user = await userHiveHelper.addUser(userModel: userModel);
    return user;
  }

  @override
  deleteUser({required String uid}) async {
    userHiveHelper.deleteUser(uid: uid);
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final users = await userHiveHelper.getUsers();
    if (users.isNotEmpty) {
      return users;
    } else {
      throw CacheException(message: 'No users found');
    }
  }

  @override
  Future<UserModel> updateUser({required UserModel updatedUserModel}) async {
    final user =
        await userHiveHelper.updateUser(updatedUserModel: updatedUserModel);
    return user;
  }
}
