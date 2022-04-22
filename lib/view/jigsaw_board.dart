import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matching/model/hive_model/user.dart';
import 'package:matching/view_model/jigsaw_view_model.dart';
import 'package:matching/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../view_model/device_view_model.dart';

class JigsawBoard extends StatelessWidget {
  const JigsawBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel thisPageUser =
        Provider.of<ProfileViewModel>(context, listen: false).currentUser!;
    Provider.of<JigsawViewModel>(context, listen: false).setUser(thisPageUser);
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
                alphabetList[index] == alphabetList[index].toLowerCase()
                    ? lowerCase = true
                    : lowerCase = false;
                late String param;
                lowerCase
                    ? param = 'l${alphabetList[index]}'
                    : param = 'u${alphabetList[index].toLowerCase()}';
                return GestureDetector(onTap: () {
                  GoRouter.of(context)
                      .pushNamed('jigsaw', params: {'id': param});
                }, child: Consumer<JigsawViewModel>(builder: (_, vm, __) {
                  return Card(
                    elevation: 3.0,
                    color:
                        vm.user!.jigsawAnswerList!.contains(alphabetList[index])
                            ? Colors.indigo
                            : Colors.white,
                    child: Center(
                        child: FittedBox(
                      child: Text(alphabetList[index].toString(),
                          style: TextStyle(
                              fontSize: 50,
                              color: lowerCase
                                  ? vm.user!.jigsawAnswerList!
                                          .contains(alphabetList[index])
                                      ? Colors.white
                                      : Colors.blue
                                  : vm.user!.jigsawAnswerList!
                                          .contains(alphabetList[index])
                                      ? Colors.white
                                      : Colors.orange)),
                      fit: BoxFit.cover,
                    )),
                  );
                }));
              },
              itemCount: alphabetList.length,
            )),
            Container(
              height: Provider.of<DeviceViewModel>(context).deviceKind == 'pad'
                  ? 100
                  : 50,
              color: Colors.indigoAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                      child: Consumer<JigsawViewModel>(builder: (_, vm, __) {
                    return Text(
                      '(${Provider.of<ProfileViewModel>(context).currentUser!.name}) 진행도 : ${vm.user!.jigsawAnswerList!.isEmpty ? 0 : (vm.user!.jigsawAnswerList!.length / alphabetList.length * 100).toInt()}%',
                      textScaleFactor: 4,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    );
                  })),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
