import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../view_model/matching_view_model.dart';

class LeftPuzzle extends StatefulWidget {
  final String status;
  final double width;
  final int index;
  const LeftPuzzle(
      {Key? key,
      required this.status,
      required this.width,
      required this.index})
      : super(key: key);

  @override
  State<LeftPuzzle> createState() => LeftPuzzleState();
}

class LeftPuzzleState extends State<LeftPuzzle>
    with SingleTickerProviderStateMixin {
  late String status;
  late double width;
  late int index;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    status = widget.status;
    width = widget.width;
    index = widget.index;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraint) {
        return Draggable(
          child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Consumer<MatchingViewModel>(
                builder: (_, vm, __) {
                  bool right = vm.getList.contains(status.toString());
                  return IgnorePointer(
                    ignoring: right,
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey.shade400),
                          color: Colors.white),
                      child: right
                          ? Lottie.network(
                              'https://assets6.lottiefiles.com/packages/lf20_oft66j9r.json',
                              controller: _controller, onLoaded: (v) {
                              _controller.forward();
                            })
                          : Image.asset('lib/images/matching/$status.png'),
                    ),
                  );
                },
              )),
          feedback: Container(
              width: width,
              height: constraint.maxHeight,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Colors.white),
              child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.asset('lib/images/matching/$status.png'))),
          childWhenDragging: Center(
              child: Text(
            status,
            style: const TextStyle(color: Colors.grey),
          )),
          data: status,
        );
      }),
    );
  }
}
