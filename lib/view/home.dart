import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../view_model/profile_view_model.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1500), () {
      if (Provider.of<ProfileViewModel>(context, listen: false).login) {
        context.go('/menu');
      } else {
        context.go('/login');
      }
    });
    return const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()));
  }
}
