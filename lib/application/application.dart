import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matching/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../router/routes.dart';
import '../view_model/device_view_model.dart';
import '../view_model/jigsaw_view_model.dart';
import '../view_model/matching_view_model.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel = ProfileViewModel();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileViewModel>(
            lazy: false, create: (_) => profileViewModel),
        ChangeNotifierProvider<DeviceViewModel>(
            lazy: false, create: (_) => DeviceViewModel()),
        ChangeNotifierProvider<MatchingViewModel>(
            lazy: false, create: (_) => MatchingViewModel()),
        ChangeNotifierProvider<JigsawViewModel>(
            lazy: false, create: (_) => JigsawViewModel()),
        Provider<MyRouter>(
          create: (_) {
            return MyRouter(profileViewModel);
          },
        )
      ],
      child: Builder(builder: (BuildContext context) {
        Provider.of<DeviceViewModel>(context, listen: false).init();
        final router = Provider.of<MyRouter>(context).router;
        return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: GoogleFonts.quicksand().fontFamily,
                visualDensity: VisualDensity.adaptivePlatformDensity),
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate);
      }),
    );
  }
}
