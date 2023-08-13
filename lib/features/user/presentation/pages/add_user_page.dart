import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_movie_star/core/routes/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../providers/user_provider.dart';
import 'package:flutter_movie_star/features/user/domain/entities/user.dart';

@RoutePage()
class AddUserPage extends ConsumerStatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends ConsumerState<AddUserPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(usersProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Add user')),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String uid = const Uuid().v4();
                  User user = User(
                    username: _usernameController.text,
                    email: _emailController.text,
                    uid: uid,
                  );
                  ref.read(usersProvider.notifier).addUser(user: user);
                  AutoRouter.of(context).push(const HomeRoute());
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
