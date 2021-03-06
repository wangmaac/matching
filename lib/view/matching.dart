import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:matching/view_model/matching_view_model.dart';
import 'package:matching/widget/finish.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
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
          ),
          Consumer<MatchingViewModel>(builder: (_, vm, __) {
            return FinishWidget(vm: vm.complete);
          })
        ],
      ),
    ));
  }
}
