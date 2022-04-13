import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matching/model/profile.dart';
import 'package:provider/provider.dart';

import '../view_model/profile_view_model.dart';

class Profile extends StatelessWidget {
  final ProfileModel profileModel;
  const Profile({Key? key, required this.profileModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ProfileViewModel>(context, listen: false)
            .setProfile(profileModel, context);
      },
      child: Card(
        elevation: 7.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 5,
              child: Image.network(
                profileModel.url,
                width: 250,
                height: 350,
                errorBuilder: (context, object, trace) => Center(
                    child: Text(
                  'No Picture',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.02),
                )),
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: Center(
                    child: Text(
                  '${profileModel.name}(${profileModel.age})',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.02),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
