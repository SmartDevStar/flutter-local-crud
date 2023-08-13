import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_movie_star/features/user/presentation/pages/home_page.dart';
import 'package:flutter_movie_star/features/user/presentation/pages/add_user_page.dart';
import 'package:flutter_movie_star/features/user/presentation/pages/update_user_page.dart';

import '../../features/user/domain/entities/user.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    CustomRoute(
        page: HomeRoute.page,
        path: '/',
        transitionsBuilder: TransitionsBuilders.fadeIn),
    CustomRoute(
        page: AddUserRoute.page,
        path: '/add',
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade),
    CustomRoute(
        page: UpdateUserRoute.page,
        path: '/update/id',
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade),
  ];
}
