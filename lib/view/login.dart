import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matching/view_model/device_view_model.dart';
import 'package:provider/provider.dart';

import '../model/profile.dart';
import '../widget/profile.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<DeviceViewModel>(context, listen: false).init();
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
                        GestureDetector(
                          child: Icon(
                            Icons.add_circle,
                            size: MediaQuery.of(context).size.width * 0.05,
                          ),
                          onTap: () {
                            context.push('/register');
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: AspectRatio(
                            aspectRatio: 9 / 12,
                            child: Container(
                              child: Profile(profileModel: profileList[index]),
                              //color: Colors.blue,
                            ),
                          ),
                        );
                        //Profile(profileModel: profileList[index]);
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
