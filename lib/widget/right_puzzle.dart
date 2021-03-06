import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:matching/view_model/matching_view_model.dart';
import 'package:provider/provider.dart';

class RightPuzzle extends StatefulWidget {
  final String value;
  final double width;
  const RightPuzzle({Key? key, required this.value, required this.width})
      : super(key: key);

  @override
  State<RightPuzzle> createState() => _RightPuzzleState();
}

class _RightPuzzleState extends State<RightPuzzle>
    with TickerProviderStateMixin {
  late String value;
  late double width;
  late AnimationController _controller;
  late AnimationController _wrongContoller;
  late Animation animation;
  AudioPlayer advancedPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

  @override
  void initState() {
    value = widget.value;
    width = widget.width;
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _wrongContoller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    animation = Tween(begin: 0.0, end: 1.0).animate(_wrongContoller);

    _wrongContoller.addStatusListener(_updateChecker);
    super.initState();
  }

  void _updateChecker(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _wrongContoller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _wrongContoller.dispose();
    _wrongContoller.removeStatusListener(_updateChecker);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DragTarget(
        builder: (context, okData, rejectData) => AnimatedBuilder(
            animation: animation,
            builder: (context, widget) {
              return Transform.translate(
                child: rightPuzzleButton(value),
                offset: Offset(10 * sin(pi * animation.value * 2 * 5), 0),
              );
            }),
        onWillAccept: (data) {
          if (data == value) {
            return true;
          } else {
            _wrongContoller.forward();
            return false;
          }
        },
        onAccept: (data) async {
          Provider.of<MatchingViewModel>(context, listen: false)
              .addAnswerList(data.toString());
          await advancedPlayer.play(
              'https://ssl.gstatic.com/dictionary/static/sounds/oxford/$data--_gb_1.mp3',
              volume: 5.0);
          _controller.forward().then((value) {
            context.read<MatchingViewModel>().completeMatching();
          });
        },
      ),
    );
  }

  Widget rightPuzzleButton(String status) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
          width: width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              color: Colors.white),
          child: Center(child: LayoutBuilder(
            builder: (context, constraint) {
              return Consumer<MatchingViewModel>(
                builder: (_, vm, __) {
                  return vm.getList.contains(status.toString())
                      ? Lottie.network(
                          'https://assets7.lottiefiles.com/packages/lf20_s2lryxtd.json',
                          controller: _controller,
                          fit: BoxFit.contain)
                      : Text(
                          status,
                          style: TextStyle(
                              fontSize: constraint.maxWidth * 0.2,
                              fontWeight: FontWeight.bold),
                        );
                },
              );
            },
          ))),
    );
  }
}
