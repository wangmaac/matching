import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../view_model/jigsaw_view_model.dart';
import '../widget/finish.dart';

class Jigsaw extends StatefulWidget {
  const Jigsaw({Key? key}) : super(key: key);

  @override
  State<Jigsaw> createState() => _JigsawState();
}

class _JigsawState extends State<Jigsaw> {
  //todo : KEY of Guide Grid Size & Position
  List<GlobalKey> keyList = [];
  final GlobalKey leftKey = GlobalKey();

  late Size leftSize;

  //todo : Guide Grid Size & Position
  List<Offset> offsetOfKeyList = [];
  List<Size> sizeOfKeyList = [];

  //todo : Main Stack Grid Size & Position --order by LTRB
  List<List> stackImageShapeList = [
    [0, 0, 0, 1],
    [1, 0, 1, 1],
    [0, 0, 0, 0],
    [0, 0, 1, 1],
    [0, 0, 0, 1],
    [1, 1, 0, 0],
    [0, 0, 0, 0],
    [1, 0, 0, 0],
    [1, 1, 0, 0],
  ];

  //todo : Stack Grid Size & Position
  List<Size> stackImageCalSizeList = [];
  List<Offset> stackImageAddPositionList = [];

  bool initComplete = false;

  late int leftPieceSize;

  final int pieceCount = 9;
  final double horizontalGridPadding = 50;

  late List<int> orderStack;

  List<Offset> leftRandomPosition = [];

  late List<bool> answerList;

  final AudioPlayer advancedPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  String getDeviceType() {
    final MediaQueryData data =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    return data.size.shortestSide < 600 ? 'mobile' : 'pad';
  }

  late String deviceKind;

  @override
  void initState() {
    deviceKind = getDeviceType();
    leftSize = Size.zero;
    Provider.of<JigsawViewModel>(context, listen: false).initViewModel();
    answerList = List.filled(pieceCount, false);
    orderStack = List.generate(pieceCount, (index) => index);
    initKeyListBuild(pieceCount);
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      initOffsetOfKeyListBuild();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    leftPieceSize = MediaQuery.of(context).size.height ~/ (pieceCount / 2);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Row(
            children: [
              //todo : left expanded
              Expanded(
                  key: leftKey,
                  flex: 1,
                  child: Stack(
                    children: initComplete
                        ? orderStack.map((e) => movingPiece(e)).toList()
                        : [],
                  )),
              //todo : right expanded
              Expanded(
                  flex: deviceKind == 'pad' ? 2 : 1,
                  child: Stack(
                    children: [
                      Center(
                        child: GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalGridPadding),
                            children: keyList
                                .asMap()
                                .map((index, value) => MapEntry(
                                    index,
                                    DragTarget(
                                      builder: (context, okList, rejectList) {
                                        return Container(
                                          key: keyList[index],
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade500,
                                          )),
                                        );
                                      },
                                      onWillAccept: (data) {
                                        if (index == data) {
                                          return true;
                                        }
                                        return false;
                                      },
                                      onAccept: (int data) {
                                        advancedPlayer.play(
                                            'https://ssl.gstatic.com/dictionary/static/sounds/oxford/wow--_gb_1.mp3',
                                            volume: 5.0);
                                        setState(() {
                                          answerList[data] = true;
                                          if (!answerList.contains(false)) {
                                            Provider.of<JigsawViewModel>(
                                                    context,
                                                    listen: false)
                                                .setComplete();
                                          }
                                        });
                                      },
                                    )))
                                .values
                                .toList()),
                      ),
                      IgnorePointer(
                        ignoring: true,
                        child: Stack(
                          children: answerList
                              .asMap()
                              .map((index, value) => MapEntry(
                                  index,
                                  initComplete
                                      ? Positioned(
                                          top: offsetOfKeyList[index].dy +
                                              stackImageAddPositionList[index]
                                                  .dy,
                                          left: offsetOfKeyList[index].dx -
                                              offsetOfKeyList.first.dx +
                                              horizontalGridPadding +
                                              stackImageAddPositionList[index]
                                                  .dx,
                                          child: Container(
                                            width: stackImageCalSizeList[index]
                                                .width,
                                            height: stackImageCalSizeList[index]
                                                .height,
                                            child: Visibility(
                                              visible: value,
                                              child: Image.asset(
                                                  'lib/images/jigsaw/p${index + 1}.png'),
                                            ),
                                            decoration: const BoxDecoration(
                                              color: Colors.transparent,
                                            ),
                                          ))
                                      : const SizedBox()))
                              .values
                              .toList(),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
        Consumer<JigsawViewModel>(builder: (_, vm, __) {
          return FinishWidget(vm: vm);
        })
      ],
    );
  }

  void initKeyListBuild(int count) {
    for (int i = 0; i < count; i++) {
      keyList.add(GlobalKey());
    }
  }

  void initOffsetOfKeyListBuild() {
    for (int i = 0; i < keyList.length; i++) {
      RenderBox box =
          keyList[i].currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      offsetOfKeyList.add(position);
      sizeOfKeyList.add(box.size);
    }
    RenderBox lBox = leftKey.currentContext!.findRenderObject() as RenderBox;
    leftSize = lBox.size;
    leftRandomPosition.add(Offset(
        Random().nextInt(leftSize.width.toInt() - leftPieceSize).toDouble(),
        Random().nextInt(leftSize.height.toInt() - leftPieceSize).toDouble()));
    initStackImageSize();
  }

  void initStackImageSize() {
    for (int i = 0; i < stackImageShapeList.length; i++) {
      int _width = 0;
      int _height = 0;
      int _positionX = 0;
      int _positionY = 0;
      for (int j = 0; j < stackImageShapeList[i].length; j++) {
        switch (j) {
          case 0: //left
            if (stackImageShapeList[i][j] == 1) {
              _width++;
              _positionX--;
            }
            break;
          case 1: //top
            if (stackImageShapeList[i][j] == 1) {
              _height++;
              _positionY--;
            }
            break;
          case 2: //right
            if (stackImageShapeList[i][j] == 1) _width++;
            break;
          case 3: //bottom
            if (stackImageShapeList[i][j] == 1) _height++;
            break;
        }
      }
      stackImageCalSizeList.add(Size(
          sizeOfKeyList[i].width + (sizeOfKeyList[i].width * (_width * 0.133)),
          sizeOfKeyList[i].height +
              (sizeOfKeyList[i].height * (_height * 0.133))));

      stackImageAddPositionList.add(Offset(
          (sizeOfKeyList[i].width * (_positionX * 0.133)),
          (sizeOfKeyList[i].height * (_positionY * 0.133))));
    }
    leftRandomPositionBuild();

    setState(() {
      initComplete = true;
    });
  }

  Widget movingPiece(int index) {
    return Positioned(
      width: leftPieceSize.toDouble(),
      height: leftPieceSize.toDouble(),
      top: leftRandomPosition[index].dy,
      left: leftRandomPosition[index].dx,
      child: Visibility(
        visible: !answerList[index],
        child: Draggable(
          data: index,
          feedback: Container(
            width: stackImageCalSizeList[index].width,
            height: stackImageCalSizeList[index].height,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                border: Border.all(width: 1, color: Colors.black)),
            child: Image.asset(
              'lib/images/jigsaw/p${index + 1}.png',
              fit: BoxFit.cover,
            ),
          ),
          childWhenDragging: Container(),
          onDragEnd: (detail) {
            double _dx = 0.0;
            double _dy = 0.0;
            double limitX = (leftSize.width.toInt() - leftPieceSize).toDouble();
            double limitY =
                (leftSize.height.toInt() - leftPieceSize).toDouble();

            if (detail.offset.dx < 0) {
              _dx = 0.0;
            } else if (detail.offset.dx > limitX) {
              _dx = limitX;
            } else {
              _dx = detail.offset.dx;
            }

            if (detail.offset.dy < 0) {
              _dy = 0.0;
            } else if (detail.offset.dy > limitY) {
              _dy = limitY;
            } else {
              _dy = detail.offset.dy;
            }

            List<int> tmp = [...orderStack];
            tmp.remove(index);
            tmp.add(index);

            setState(() {
              leftRandomPosition[index] = Offset(_dx, _dy);
              orderStack = tmp;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                border: Border.all(width: 1, color: Colors.black)),
            child: Image.asset(
              'lib/images/jigsaw/p${index + 1}.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void leftRandomPositionBuild() {
    for (int i = 0; i < pieceCount; i++) {
      leftRandomPosition.add(Offset(
          Random().nextInt(leftSize.width.toInt() - leftPieceSize).toDouble(),
          Random()
              .nextInt(leftSize.height.toInt() - leftPieceSize)
              .toDouble()));
    }
  }
}
