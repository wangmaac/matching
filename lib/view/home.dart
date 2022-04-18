import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../view_model/profile_view_model.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (!Provider.of<ProfileViewModel>(context, listen: false).checkLogin()) {
        GoRouter.of(context).go('/login');
      } else {
        GoRouter.of(context).go('/menu');
      }
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text('로그인 확인 중입니다.'),
          ),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator.adaptive()
        ],
      ),
    );
  }
}
