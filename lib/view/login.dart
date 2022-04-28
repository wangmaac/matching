import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:matching/view_model/profile_view_model.dart';
import 'package:matching/widget/profile_empty.dart';
import 'package:provider/provider.dart';

import '../model/hive_model/user.dart';
import '../widget/profile.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Provider.of<ProfileViewModel>(context, listen: false)
          .setLongPress(false),
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/profile_background.png'),
                fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: DefaultTextStyle(
                style: GoogleFonts.quicksand(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Who are you?',
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ValueListenableBuilder(
                          valueListenable:
                              Hive.box<UserModel>('user').listenable(),
                          builder: (context, Box<UserModel> box, child) {
                            if (box.isEmpty) {
                              return const ProfileEmpty();
                            } else {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  if (index == box.length - 1) {
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: AspectRatio(
                                            aspectRatio: 9 / 12,
                                            child: Profile(
                                                selectUser: box.getAt(index)!),
                                          ),
                                        ),
                                        const ProfileEmpty()
                                      ],
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: AspectRatio(
                                        aspectRatio: 9 / 12,
                                        child: Profile(
                                            selectUser: box.getAt(index)!),
                                      ),
                                    );
                                  }
                                },
                                itemCount: box.length,
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
