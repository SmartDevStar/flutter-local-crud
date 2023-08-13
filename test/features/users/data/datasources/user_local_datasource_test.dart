import 'package:flutter_movie_star/core/exception.dart';
import 'package:flutter_movie_star/features/user/data/datasources/user_hive_helper.dart';
import 'package:flutter_movie_star/features/user/data/datasources/user_local_datasource.dart';
import 'package:flutter_movie_star/features/user/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockUserHiveHelper extends Mock implements UserHiveHelper {}

void main() {
  late UserLocalDataSource userLocalDataSourceImpl;
  late MockUserHiveHelper mockUserHiveHelper;
  late List<UserModel> userModels;
  late UserModel userModel;

  setUp(
    () {
      mockUserHiveHelper = MockUserHiveHelper();
      userLocalDataSourceImpl =
          UserLocalDataSourceImpl(userHiveHelper: mockUserHiveHelper);
      userModels = getMockUsers();
      userModel = getMockUser();
    },
  );

  group(
    'CRUD Users',
    () {
      test(
        'Should return a list of users from cache when there is data in cache',
        () async {
          // Arange
          when((() => mockUserHiveHelper.getUsers()))
              .thenAnswer((invocation) => Future.value(userModels));

          final result = await userLocalDataSourceImpl.getUsers();

          expect(result, userModels);
          verify((() => mockUserHiveHelper.getUsers())).called(1);
          verifyNoMoreInteractions(mockUserHiveHelper);
        },
      );
      test(
        'Should throw a CacheException when there is no data in cache',
        () async {
          // Arange
          when((() => mockUserHiveHelper.getUsers()))
              .thenAnswer((invocation) => Future.value(List.empty()));
          //Assert
          expect(
              () async => userLocalDataSourceImpl.getUsers(),
              throwsA(predicate((p0) =>
                  p0 is CacheException && p0.message == 'No users found')));
          verify((() => mockUserHiveHelper.getUsers())).called(1);
          verifyNoMoreInteractions(mockUserHiveHelper);
        },
      );
      test(
        'Should call HiveHelper to add an user',
        () async {
          when((() => mockUserHiveHelper.addUser(userModel: userModel)))
              .thenAnswer((invocation) => Future.value(userModel));
          final result =
              await userLocalDataSourceImpl.addUser(userModel: userModel);
          expect(result, userModel);
          verify((() => mockUserHiveHelper.addUser(userModel: userModel)))
              .called(1);
        },
      );
    },
  );
}
