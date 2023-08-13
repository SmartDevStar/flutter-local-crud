import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_movie_star/core/routes/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user.dart';
import '../providers/user_provider.dart';

@RoutePage()
class UpdateUserPage extends ConsumerWidget {
  final User user;
  final String id;
  UpdateUserPage(
      {@PathParam('id') required this.id, super.key, required this.user});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _usernameController.text = user.username;
    _emailController.text = user.email;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Update user')),
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
                  User user = User(
                    username: _usernameController.text,
                    email: _emailController.text,
                    uid: id,
                  );
                  ref.read(usersProvider.notifier).updateUser(newUser: user);
                  AutoRouter.of(context).push(const HomeRoute());
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
