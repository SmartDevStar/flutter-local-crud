import 'dart:convert';
import 'dart:io';

import 'package:flutter_movie_star/features/user/data/models/user_model.dart';

String fixtureUsers(String name) =>
    File('test/features/users/fixtures/$name').readAsStringSync();

List<UserModel> getMockUsers() {
  final response = json.decode(fixtureUsers('user_models.json'));
  final results = response['result'];
  return (results as List).map((user) => UserModel.fromJson(user)).toList();
}

UserModel getMockUser() {
  final response = json.decode(fixtureUsers('user_model.json'));
  final result = response['result'][0];
  return UserModel.fromJson(result);
}
