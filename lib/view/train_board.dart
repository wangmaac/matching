import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matching/utils/constants.dart';

class TrainBoard extends StatelessWidget {
  const TrainBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, index) {
                  String _st = sentenceList[index].id;
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    title: Text(_st),
                    leading: const Icon(Icons.attractions),
                    onTap: () {
                      GoRouter.of(context)
                          .pushNamed('train', params: {'sentence': _st});
                    },
                  );
                },
                itemCount: sentenceList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
