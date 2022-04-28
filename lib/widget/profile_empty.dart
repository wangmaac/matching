import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../view_model/profile_view_model.dart';

class ProfileEmpty extends StatelessWidget {
  const ProfileEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 9 / 12,
        child: GestureDetector(
          onTap: () {
            Provider.of<ProfileViewModel>(context, listen: false)
                .setLongPress(false);
            GoRouter.of(context).push('/register');
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white60),
            child: Icon(
              Icons.add_circle,
              size: MediaQuery.of(context).size.width * 0.09,
            ),
          ),
        ),
      ),
    );
  }
}
