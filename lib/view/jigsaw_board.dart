import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:matching/view_model/jigsaw_view_model.dart';
import 'package:provider/provider.dart';

import '../view_model/device_view_model.dart';

class JigsawBoard extends StatelessWidget {
  const JigsawBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z',
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10),
                itemBuilder: (context, index) {
                  late bool lowerCase;
                  list[index] == list[index].toLowerCase()
                      ? lowerCase = true
                      : lowerCase = false;
                  late String param;
                  lowerCase
                      ? param = 'l${list[index]}'
                      : param = 'u${list[index].toLowerCase()}';
                  return GestureDetector(
                    onTap: () {
                      GoRouter.of(context)
                          .pushNamed('jigsaw', params: {'id': param});
                    },
                    child: Consumer<JigsawViewModel>(builder: (_, vm, __) {
                      return Card(
                        elevation: 3.0,
                        color: vm.answerList.contains(list[index])
                            ? Colors.indigo
                            : Colors.white,
                        child: Center(
                            child: FittedBox(
                          child: Text(list[index].toString(),
                              style: TextStyle(
                                  fontSize: 50,
                                  color: lowerCase
                                      ? vm.answerList.contains(list[index])
                                          ? Colors.white
                                          : Colors.blue
                                      : vm.answerList.contains(list[index])
                                          ? Colors.white
                                          : Colors.orange)),
                          fit: BoxFit.cover,
                        )),
                      );
                    }),
                  );
                },
                itemCount: list.length,
              ),
            ),
            Container(
              height: Provider.of<DeviceViewModel>(context).deviceKind == 'pad'
                  ? 100
                  : 50,
              color: Colors.indigoAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      '진행도 : ${Provider.of<JigsawViewModel>(context).answerList.isEmpty ? 0 : (Provider.of<JigsawViewModel>(context).answerList.length / list.length * 100).toInt()}%',
                      textScaleFactor: 4,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
