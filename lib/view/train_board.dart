import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matching/utils/constants.dart';

class TrainBoard extends StatelessWidget {
  const TrainBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.06;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Lists of items',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, index) {
                  return const Divider(
                    color: Colors.black,
                    thickness: 0.5,
                    indent: 30,
                    height: 50,
                    endIndent: 30,
                  );
                },
                itemBuilder: (_, index) {
                  String _st = sentenceList[index].id;
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    title: Text(
                      _st.replaceAll('  ', ' / '),
                      style: TextStyle(fontSize: fontSize),
                    ),
                    leading: Icon(
                      Icons.adjust_outlined,
                      size: fontSize,
                      color: Colors.black,
                    ),
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
