import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matching/model/menu_button.dart';
import 'package:matching/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MenuButtonModel> menuButtonList = [
      MenuButtonModel(
          navUrl: 'matching', imageUrl: 'lib/images/puzzle_button.png'),
      MenuButtonModel(
          navUrl: 'jigsawBoard', imageUrl: 'lib/images/jigsaw_button.png'),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xff2699D6), Color(0xff031A2D)])),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: Provider.of<ProfileViewModel>(context).isLogin
                    ? [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            Provider.of<ProfileViewModel>(context)
                                .currentProfile!
                                .name,
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ]
                    : [],
              ),
            ), //TITLE BAR
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: menuButtonList
                      .map((model) =>
                          menuButton(context, model.navUrl, model.imageUrl))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuButton(BuildContext context, String navURL, String imageURL) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).pushNamed(navURL),
      //onTap: () => GoRouter.of(context).go(navURL),
      child: Container(
        width: MediaQuery.of(context).size.height / 4,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(imageURL)),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(5, 5),
                  color: Colors.black38,
                  spreadRadius: 1,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}
