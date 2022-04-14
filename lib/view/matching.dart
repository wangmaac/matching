import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:matching/view_model/matching_view_model.dart';
import 'package:provider/provider.dart';

import '../widget/left_puzzle.dart';
import '../widget/right_puzzle.dart';

class Matching extends StatefulWidget {
  const Matching({Key? key}) : super(key: key);

  @override
  State<Matching> createState() => _MatchingState();
}

class _MatchingState extends State<Matching> {
  List leftPuzzleList = [];
  List rightPuzzleList = [];
  AudioCache audioCache = AudioCache();

  @override
  void initState() {
    context.read<MatchingViewModel>().resetAnswerList();
    initPuzzleRandom();
    //createKeys();
    if (Platform.isIOS) {
      audioCache.fixedPlayer?.notificationService.startHeadlessService();
    }
    super.initState();
  }

  void initPuzzleRandom() {
    leftPuzzleList = ['angry', 'sad', 'happy', 'scared'];
    rightPuzzleList.addAll(leftPuzzleList);
    leftPuzzleList.shuffle();
    rightPuzzleList.shuffle();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width / 6;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: leftPuzzleList
                      .asMap()
                      .map((index, e) => MapEntry(
                          index,
                          LeftPuzzle(
                            index: index,
                            status: e.toString(),
                            width: buttonWidth,
                          )))
                      .values
                      .toList()),
              Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: rightPuzzleList
                      .asMap()
                      .map((index, e) => MapEntry(
                          index,
                          RightPuzzle(
                            value: e.toString(),
                            width: buttonWidth,
                          )))
                      .values
                      .toList()),
            ],
          ),
          Consumer<MatchingViewModel>(builder: (_, vm, __) {
            return Visibility(
              visible: vm.complete,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: Lottie.network(
                          'https://assets9.lottiefiles.com/packages/lf20_l4xxtfd3.json'),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => GoRouter.of(context).pop(),
                      child: const Text('back'))
                ],
              ),
            );
          })
        ],
      ),
    ));
  }
}
