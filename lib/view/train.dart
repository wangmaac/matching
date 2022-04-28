import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:matching/view_model/device_view_model.dart';
import 'package:provider/provider.dart';

import '../widget/finish.dart';

enum Progress { ING, WRONG, SUCCESS }

class Train extends StatefulWidget {
  final String sentence;
  const Train({Key? key, required this.sentence}) : super(key: key);

  @override
  State<Train> createState() => _TrainState();
}

class _TrainState extends State<Train> with TickerProviderStateMixin {
  late double _deviceWidth;
  late double _deviceHeight;
  late List<String> _resultList;
  late List<String> originalList;

  List<int> _resultIndexList = [];
  List<GlobalKey> gk = [];
  List<Offset> gkOffsetList = [];
  List<Size> gkSizeList = [];

  Progress status = Progress.ING;

  bool show = true;

  late List<String> userAnswerList;

  late double pieceSize;

  late AnimationController animationController;
  late AnimationController lottieController;

  @override
  void initState() {
    _resultList = getSentence(widget.sentence);
    userAnswerList = List.filled(_resultList.length, '');
    originalList = [..._resultList];
    _resultList.shuffle();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    lottieController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    for (int i = 0; i < originalList.length; i++) {
      _resultIndexList.add(originalList.indexOf(_resultList[i]));
    }
    initialGlobalKey();

    animationController.addStatusListener(_updateStatus);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    lottieController.dispose();
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    pieceSize = _deviceWidth / originalList.length;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Train oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    _resultList.length,
                    (index) => Draggable(
                        data: _resultIndexList[index],
                        feedback: Material(
                            color: Colors.transparent,
                            child: Center(
                                child: Text(
                              _resultList[index].toString(),
                              style: TextStyle(fontSize: _deviceWidth * 0.05),
                            ))),
                        childWhenDragging: const SizedBox(),
                        child: userAnswerList.contains(_resultList[index])
                            ? emptyBox()
                            : Container(
                                height: _deviceHeight / 6,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Center(
                                    child: Text(
                                  _resultList[index],
                                  style: TextStyle(
                                      fontSize: _deviceWidth * 0.05,
                                      fontWeight: FontWeight.bold),
                                )),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Colors.indigoAccent),
                                  color: Colors.yellowAccent,
                                ),
                              ))),
              )),
              Expanded(
                child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, snapshot) {
                      return Transform.translate(
                        offset: Offset(
                            -_deviceWidth * animationController.value, 0),
                        child: Visibility(
                          visible: show,
                          child: SizedBox(
                            width: _deviceWidth,
                            child: FittedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    List.generate(_resultList.length, (index) {
                                  if (index == 0) {
                                    return Row(
                                      children: [
                                        const SizedBox(width: 200),
                                        SizedBox(
                                          width: pieceSize,
                                          height: pieceSize,
                                          child: Image.asset(
                                            'lib/images/sentence/head.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        targetWidget(index),
                                      ],
                                    );
                                  } else if (index == _resultList.length - 1) {
                                    return Row(
                                      children: [
                                        targetWidget(index),
                                        SizedBox(
                                          width: pieceSize,
                                          height: pieceSize,
                                          child: Image.asset(
                                            'lib/images/sentence/tail.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    if (index == 2) {
                                      return targetWidget(index);
                                    } else {
                                      return targetWidget(index);
                                    }
                                  }
                                }),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            visualDensity:
                                VisualDensity.adaptivePlatformDensity),
                        onPressed: () {
                          setState(() {
                            resetFunction();
                          });
                        },
                        child: SizedBox(
                            child: Center(
                                child: Text(
                              'reset',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.02,
                                  fontWeight: FontWeight.bold),
                            )),
                            height: Provider.of<DeviceViewModel>(context)
                                        .deviceKind ==
                                    DeviceKind.Pad
                                ? 80
                                : 50),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            visualDensity:
                                VisualDensity.adaptivePlatformDensity),
                        onPressed: () {
                          if (listEquals(userAnswerList, originalList)) {
                            animationController.forward().then((value) {
                              setState(() {
                                status = Progress.SUCCESS;
                                show = false;
                              });
                            });
                          } else {
                            setState(() {
                              status = Progress.WRONG;
                            });
                          }
                        },
                        child: SizedBox(
                          child: Center(
                              child: Text(
                            'submit',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.02,
                                fontWeight: FontWeight.bold),
                          )),
                          height: Provider.of<DeviceViewModel>(context)
                                      .deviceKind ==
                                  DeviceKind.Pad
                              ? 80
                              : 50,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          status == Progress.WRONG
              ? Builder(builder: (context) {
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    lottieController.forward().then((value) {
                      setState(() {
                        resetFunction();
                      });
                    });
                  });
                  return Container(
                      width: _deviceWidth,
                      height: _deviceHeight,
                      color: Colors.white60,
                      child: Lottie.asset(
                        'lib/images/sentence/bomb.json',
                        fit: BoxFit.fill,
                        controller: lottieController,
                      )
                      /*Lottie.network(
                      'https://assets6.lottiefiles.com/private_files/lf30_ogrm1vj2.json',
                      fit: BoxFit.fill,
                      controller: lottieController,
                    ),*/
                      );
                })
              : status == Progress.SUCCESS
                  ? const FinishWidget(vm: true)
                  : emptyBox()
        ],
      ),
    ));
  }

  List<String> getSentence(String sentence) {
    return sentence.split('  ');
  }

  void initialGlobalKey() {
    for (int i = 0; i < _resultList.length; i++) {
      gk.add(GlobalKey());
    }
  }

  void initialGKOffset() {
    gkOffsetList.clear();
    gkSizeList.clear();
    for (int i = 0; i < gk.length; i++) {
      RenderBox box = gk[i].currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      gkOffsetList.add(position);
      gkSizeList.add(box.size);
    }
  }

  Widget targetWidget(int index) {
    return DragTarget(
      builder: (context, okList, rejectList) {
        return Stack(
          children: [
            SizedBox(
              width: pieceSize,
              height: pieceSize,
              child: Image.asset(
                'lib/images/sentence/$index.png',
                fit: BoxFit.contain,
              ),
            ),
            userAnswerList[index] != ''
                ? SizedBox(
                    width: pieceSize,
                    height: pieceSize,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        userAnswerList[index],
                        style: TextStyle(fontSize: pieceSize * 0.15),
                      ),
                    )),
                  )
                : emptyBox()
          ],
        );
      },
      onAccept: (data) {
        setState(() {
          userAnswerList[index] = originalList[data as int];
        });
      },
      onWillAccept: (data) {
        return true;
      },
    );
  }

  Widget emptyBox() {
    return const SizedBox();
  }

  void resetFunction() {
    userAnswerList = List.filled(_resultList.length, '');
    animationController.reset();
    lottieController.reset();
    status = Progress.ING;
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }
}
