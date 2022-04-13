import 'package:flutter/material.dart';

class Matching extends StatelessWidget {
  const Matching({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List leftPuzzleList = ['angry', 'sad', 'happy', 'scared'];
    List rightPuzzleList = ['angry', 'sad', 'happy', 'scared'];
    leftPuzzleList.shuffle();
    rightPuzzleList.shuffle();
    return Scaffold(
        body: SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  leftPuzzleList.map((e) => leftPuzzle(e.toString())).toList()),
          const SizedBox(
            width: 100,
          ),
          Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: rightPuzzleList
                  .map((e) => rightPuzzle(e.toString()))
                  .toList()),
        ],
      ),
    ));
  }

  Widget leftPuzzle(String status) {
    return Expanded(
      child: Draggable(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Colors.white),
              child: Image.asset('lib/images/matching/$status.png')),
        ),
        feedback: Container(
            width: 200,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                color: Colors.white),
            child: AspectRatio(
                aspectRatio: 10 / 10,
                child: Image.asset('lib/images/matching/$status.png'))),
        childWhenDragging: Center(
            child: Text(
          status,
          style: const TextStyle(color: Colors.grey),
        )),
        data: status,
      ),
    );
  }

  Widget rightPuzzle(String status) {
    return Expanded(
        child: DragTarget(
      onWillAccept: (data) {
        if (status == data) {
          return true;
        }
        return false;
      },
      onAccept: (data) {
        print(data.toString());
      },
      builder: (context, list, data) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              width: 180,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Colors.white),
              child: Center(child: LayoutBuilder(
                builder: (context, constraint) {
                  return Text(
                    status,
                    style: TextStyle(
                        fontSize: constraint.maxWidth * 0.2,
                        fontWeight: FontWeight.bold),
                  );
                },
              ))),
        );
      },
    ));
  }
}
