import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_movie_star/core/routes/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_provider.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(usersProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('User Management')),
        body: state is GetUsersSuccess
            ? ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    onTap: () {
                      AutoRouter.of(context)
                          .push(UpdateUserRoute(id: user.uid, user: user));
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_forever_outlined),
                      onPressed: () {
                        ref
                            .read(usersProvider.notifier)
                            .deleteUser(uid: user.uid);
                      },
                    ),
                    title: Text(user.username),
                    subtitle: Text(user.email),
                  );
                })
            : state is GetUsersLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state is GetUsersError
                    ? Center(child: Text(state.errorMessage))
                    : const SizedBox.shrink(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            AutoRouter.of(context).push(const AddUserRoute());
          },
        ),
      ),
    );
  }
}
