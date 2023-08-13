import 'package:flutter_movie_star/features/user/data/models/user_model.dart';
import 'package:flutter_movie_star/features/user/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const userModel = UserModel(
    username: 'Rohan01',
    email: 'rohan01@gmail.com',
    uid: '1',
  );

  group(
    'Model Mapping',
    () {
      test(
        'Should successfully convert to a User entity',
        () {
          final user = userModel.toUser;
          expect(user, isA<User>());
          expect(user.username, userModel.username);
          expect(user.email, userModel.email);
        },
      );
      test(
        'Model should successfully deserialize from JSON',
        () {
          final model = getMockUser();
          expect(model, isA<UserModel>());
          expect(model, userModel);
        },
      );
    },
  );
}
