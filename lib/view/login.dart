import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/profile.dart';
import '../widget/profile.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List profileList = [
      ProfileModel(
          name: '마루치',
          age: 9,
          url:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtNy7bmHvQEaTWj9L2wP1NiwJhQBZVvbopRw&usqp=CAU'),
      ProfileModel(
          name: '아라치',
          age: 9,
          url:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSS5ZQJhO7su-dBHZcUzVWl06mj9slXYcyW9w&usqp=CAU'),
      ProfileModel(
          name: '가물치',
          age: 10,
          url:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqaV1jsp0fPmumrlnceXZxxX0ifD9KXxaWkQ&usqp=CAU'),
    ];

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/images/profile_background.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            minimum: const EdgeInsets.all(50),
            child: DefaultTextStyle(
              style: GoogleFonts.quicksand(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              child: Column(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Who are you?',
                    )),
                  ),
                  Expanded(
                    flex: 2,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 9 / 11,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 15,
                      ),
                      itemBuilder: (context, index) {
                        return Profile(profileModel: profileList[index]);
                      },
                      itemCount: profileList.length,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
