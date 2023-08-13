import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_movie_star/core/exception.dart';

import '../models/user_model.dart';
import 'user_local_datasource.dart';

class UserHiveHelper implements UserLocalDataSource {
  Future<Box<UserModel>> _getBox() async {
    Box<UserModel> box;
    box = await Hive.openBox<UserModel>('users');
    return box;
  }

  @override
  Future<UserModel> addUser({required UserModel userModel}) async {
    final box = await _getBox();
    box.put(userModel.uid, userModel);
    return userModel;
  }

  @override
  void deleteUser({required String uid}) async {
    final box = await _getBox();
    box.delete(uid);
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final box = await _getBox();
    final users = box.values.toList();
    return users;
  }

  @override
  Future<UserModel> updateUser({required UserModel updatedUserModel}) async {
    final box = await _getBox();
    final userModel = box.get(updatedUserModel.uid);
    if (userModel == null) {
      throw CacheException(message: 'No users found');
    } else {
      box.put(updatedUserModel.uid, updatedUserModel);
      return updatedUserModel;
    }
  }
}
