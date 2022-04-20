import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matching/view/jigsaw.dart';
import 'package:matching/view/jigsaw_board.dart';
import 'package:matching/view/register.dart';
import 'package:matching/view_model/profile_view_model.dart';

import '../view/error.dart';
import '../view/login.dart';
import '../view/matching.dart';
import '../view/menu.dart';

class MyRouter {
  final ProfileViewModel loginState;
  MyRouter(this.loginState);
  late final router = GoRouter(
    refreshListenable: loginState,
    debugLogDiagnostics: true, //앱 출시전에 제거
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        name: 'root',
        path: '/',
        redirect: (state) => state.namedLocation('login'),
      ),
      GoRoute(
          name: 'login',
          path: '/login',
          pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const Login(),
              ),
          routes: [
            GoRoute(
              name: 'menu',
              path: 'menu',
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const Menu(),
              ),
              routes: [
                GoRoute(
                  name: 'matching',
                  path: 'matching',
                  pageBuilder: (context, state) => MaterialPage<void>(
                    key: state.pageKey,
                    child: const Matching(),
                  ),
                ),
                GoRoute(
                    name: 'jigsawBoard',
                    path: 'jigsawBoard',
                    pageBuilder: (context, state) => MaterialPage<void>(
                          key: state.pageKey,
                          child: const JigsawBoard(),
                        ),
                    routes: [
                      GoRoute(
                          name: 'jigsaw',
                          path: ':id',
                          pageBuilder: (context, state) {
                            final String id = state.params['id'].toString();
                            return MaterialPage<void>(
                              key: state.pageKey,
                              child: Jigsaw(id: id),
                            );
                          }),
                    ]),
              ],
            ),
          ]),
      GoRoute(
        name: 'register',
        path: '/register',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const Register(),
        ),
      ),
    ],

    redirect: (state) {
      //login page?
      final loginLoc = state.namedLocation('login');
      final loggingIn = state.subloc == loginLoc;

      //register page?
      final createAccountLoc = state.namedLocation('register');
      final creatingAccount = state.subloc == createAccountLoc;

      //isLogin?
      final loggedIn = loginState.isLogin;

      final rootLoc = state.namedLocation('root');

      // 로그인안되어있고, 로그인페이지도 아니고, 계정생성도 아니야? 그럼 로그인페이지
      if (!loggedIn && !loggingIn && !creatingAccount) {
        print('// 로그인안되어있고, 로그인페이지도 아니고, 계정생성도 아니야? 그럼 로그인페이지');
        return loginLoc;
      }
      //로그인인데,,, 로그인페이지 또는 계정페이지이면
      //if (loggedIn && (loggingIn || creatingAccount)) return rootLoc;
      return null;
    },

    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
  );
}
