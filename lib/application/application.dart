import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matching/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../view/home.dart';
import '../view/jigsaw.dart';
import '../view/login.dart';
import '../view/matching.dart';
import '../view/menu.dart';
import '../view_model/device_view_model.dart';
import '../view_model/jigsaw_view_model.dart';
import '../view_model/matching_view_model.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoRouter _goRouter = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(path: '/', builder: (_, state) => const Home(), routes: [
            GoRoute(path: 'login', builder: (_, state) => const Login()),
            GoRoute(path: 'menu', builder: (_, state) => const Menu(), routes: [
              GoRoute(
                  path: 'matching', builder: (_, state) => const Matching()),
              GoRoute(path: 'jigsaw', builder: (_, state) => const Jigsaw()),
            ]),
            //GoRoute(path: '/register', builder: (_, state) => const Register()),
          ]),
        ],
        errorPageBuilder: (context, state) => MaterialPage(
                child: Scaffold(
              body: Center(
                child: Text(state.error.toString()),
              ),
            )));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => DeviceViewModel()),
        ChangeNotifierProvider(create: (_) => MatchingViewModel()),
        ChangeNotifierProvider(create: (_) => JigsawViewModel()),
      ],
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: GoogleFonts.quicksand().fontFamily,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          routeInformationParser: _goRouter.routeInformationParser,
          routerDelegate: _goRouter.routerDelegate),
    );
  }
}
