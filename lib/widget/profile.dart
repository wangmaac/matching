import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../model/hive_model/user.dart';
import '../view_model/profile_view_model.dart';

class Profile extends StatelessWidget {
  final UserModel selectUser;
  const Profile({Key? key, required this.selectUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ProfileViewModel>(context, listen: false)
            .setProfile(selectUser);
        context.goNamed('menu');
      },
      onLongPress: () {
        Provider.of<ProfileViewModel>(context, listen: false)
            .setLongPress(true);
      },
      child: Consumer<ProfileViewModel>(builder: (_, vm, __) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5),
              child: Card(
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Image.file(
                          File(selectUser.image),
                          errorBuilder: (context, object, trace) {
                            return Center(
                                child: Text(
                              'No Picture',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.02),
                            ));
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                          child: Center(
                              child: Text(
                            '${selectUser.name}(${selectUser.age})',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                child: vm.isLongPress ? deleteButton() : Container(),
                onTap: () async {
                  final box = Hive.box<UserModel>('user');
                  await box
                      .delete(selectUser.name)
                      .then((value) => print('delete complete'));
                },
              ),
            )
          ],
        );
      }),
    );
  }

  Widget deleteButton() {
    return const SizedBox(
      width: 50,
      height: 50,
      child: Align(
        alignment: Alignment.topLeft,
        child: Icon(
          Icons.cancel,
          color: Colors.indigo,
          size: 60,
        ),
      ),
    );
  }
}
