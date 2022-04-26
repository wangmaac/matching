import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:matching/model/sentence.dart';
import 'package:matching/view_model/device_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class Train extends StatefulWidget {
  final String sentence;
  const Train({Key? key, required this.sentence}) : super(key: key);

  @override
  State<Train> createState() => _TrainState();
}

class _TrainState extends State<Train> {
  late double _deviceWidth;
  late double _deviceHeight;
  late List<String> _resultList;

  List<GlobalKey> gk = [];
  List<Offset> gkOffsetList = [];
  List<Size> gkSizeList = [];

  @override
  void initState() {
    _resultList = getSentence(widget.sentence);
    initialGlobalKey();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      initialGKOffset();
      print(gkOffsetList.toString());
      print(gkSizeList.toString());
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    _resultList.length,
                    (index) => Draggable(
                          feedback: Material(
                              color: Colors.transparent,
                              child: Center(
                                  child: Text(
                                _resultList[index].toString(),
                                style: TextStyle(fontSize: _deviceWidth * 0.05),
                              ))),
                          childWhenDragging: const SizedBox(),
                          child: Container(
                            height: _deviceHeight / 6,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                                child: Text(
                              _resultList[index],
                              style: TextStyle(fontSize: _deviceWidth * 0.05),
                            )),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: Colors.indigoAccent),
                              color: Colors.yellowAccent,
                            ),
                          ),
                        )),
              )),
              Expanded(
                child: SizedBox(
                  width: constraint.maxWidth,
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_resultList.length, (index) {
                        if (index == 0) {
                          return Row(
                            children: [
                              const SizedBox(width: 100),
                              Image.asset('lib/images/sentence/head.png'),
                              Image.asset('lib/images/sentence/$index.png',
                                  key: gk[index]),
                            ],
                          );
                        } else if (index == _resultList.length - 1) {
                          return Row(
                            children: [
                              Image.asset('lib/images/sentence/$index.png',
                                  key: gk[index]),
                              Image.asset('lib/images/sentence/tail.png'),
                            ],
                          );
                        } else {
                          return Image.asset('lib/images/sentence/$index.png',
                              key: gk[index]);
                        }
                      }),
                    ),
                  ),
                ),
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
                        onPressed: () {},
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
                        onPressed: () {},
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
        );
      }),
    );
  }

  List<String> getSentence(String sentence) {
    List<SentenceModel> result =
        sentenceList.where((model) => model.id == sentence.trim()).toList();
    return result.first.sentence;
  }

  void initialGlobalKey() {
    for (int i = 0; i < _resultList.length; i++) {
      gk.add(GlobalKey());
    }
  }

  void initialGKOffset() {
    for (int i = 0; i < gk.length; i++) {
      RenderBox box = gk[i].currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      gkOffsetList.add(position);
      gkSizeList.add(box.size);
    }
  }
}
