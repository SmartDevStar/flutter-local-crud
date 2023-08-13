import 'package:equatable/equatable.dart';
import 'package:flutter_movie_star/core/failure.dart';
import 'package:flutter_movie_star/features/user/data/datasources/user_hive_helper.dart';
import 'package:flutter_movie_star/features/user/data/datasources/user_local_datasource.dart';
import 'package:flutter_movie_star/features/user/data/repositories/user_repository_impl.dart';
import 'package:flutter_movie_star/features/user/domain/usecases/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user.dart';

final usersProvider = NotifierProvider<UsersNotifier, GetUsersState>(() {
  return UsersNotifier(
    userUsecase: UserUsecase(
      userRepository: UserRepositoryImpl(
        userLocalDataSource:
            UserLocalDataSourceImpl(userHiveHelper: UserHiveHelper()),
      ),
    ),
    storedUsers: [],
  );
});

class UsersNotifier extends Notifier<GetUsersState> {
  final UserUsecase userUsecase;
  List<User> storedUsers;
  UsersNotifier({required this.userUsecase, required this.storedUsers});

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case CacheFailure:
        return (failure as CacheFailure).message;
      case CastFailure:
        return (failure as CastFailure).message;
      default:
        return 'Unknown Error';
    }
  }

  void getUsers() async {
    state = GetUsersLoading();
    final result = await userUsecase.getUsers();
    result.fold(
        (failure) => state =
            GetUsersError(errorMessage: _getErrorMessage(failure)), (users) {
      storedUsers = users
        ..sort((a, b) {
          return a.username.compareTo(b.username);
        });
      state = GetUsersSuccess(users: storedUsers);
    });
  }

  void addUser({required User user}) async {
    state = GetUsersLoading();
    final result = await userUsecase.addUser(user: user);
    result.fold(
        (failure) => state =
            GetUsersError(errorMessage: _getErrorMessage(failure)), (user) {
      storedUsers.add(user);
      state = GetUsersSuccess(users: storedUsers);
    });
  }

  void updateUser({required User newUser}) async {
    state = GetUsersLoading();
    final result = await userUsecase.updateUser(newUser: newUser);
    result.fold(
        (failure) => state =
            GetUsersError(errorMessage: _getErrorMessage(failure)), (user) {
      final index =
          storedUsers.indexWhere((element) => element.uid == user.uid);
      storedUsers[index] = user;
      state = GetUsersSuccess(users: storedUsers);
    });
  }

  void deleteUser({required String uid}) async {
    state = GetUsersLoading();
    userUsecase.deleteUser(uid: uid);
    final index = storedUsers.indexWhere((element) => element.uid == uid);
    storedUsers.removeAt(index);
    state = GetUsersSuccess(users: storedUsers);
  }

  @override
  GetUsersState build() {
    return GetUsersInitial();
  }
}

abstract class GetUsersState extends Equatable {}

class GetUsersInitial extends GetUsersState {
  @override
  List<Object?> get props => [];
}

class GetUsersLoading extends GetUsersState {
  @override
  List<Object?> get props => [];
}

class GetUsersSuccess extends GetUsersState {
  final List<User> users;

  GetUsersSuccess({required this.users});

  @override
  List<Object?> get props => [users];
}

class GetUsersError extends GetUsersState {
  final String errorMessage;

  GetUsersError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
