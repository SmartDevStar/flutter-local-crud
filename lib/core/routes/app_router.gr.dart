// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddUserRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddUserPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    UpdateUserRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateUserRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UpdateUserPage(
          id: args.id,
          key: args.key,
          user: args.user,
        ),
      );
    },
  };
}

/// generated route for
/// [AddUserPage]
class AddUserRoute extends PageRouteInfo<void> {
  const AddUserRoute({List<PageRouteInfo>? children})
      : super(
          AddUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddUserRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UpdateUserPage]
class UpdateUserRoute extends PageRouteInfo<UpdateUserRouteArgs> {
  UpdateUserRoute({
    required String id,
    Key? key,
    required User user,
    List<PageRouteInfo>? children,
  }) : super(
          UpdateUserRoute.name,
          args: UpdateUserRouteArgs(
            id: id,
            key: key,
            user: user,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'UpdateUserRoute';

  static const PageInfo<UpdateUserRouteArgs> page =
      PageInfo<UpdateUserRouteArgs>(name);
}

class UpdateUserRouteArgs {
  const UpdateUserRouteArgs({
    required this.id,
    this.key,
    required this.user,
  });

  final String id;

  final Key? key;

  final User user;

  @override
  String toString() {
    return 'UpdateUserRouteArgs{id: $id, key: $key, user: $user}';
  }
}
