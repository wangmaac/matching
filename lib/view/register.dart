import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../view_model/device_view_model.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController _controllerName;
  late TextEditingController _controllerAge;

  List<XFile> _imageFileList = [];

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    _controllerName = TextEditingController();
    _controllerAge = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: _width / 3,
            child: Column(
              children: [
                //Image.file(File(_imageFileList![index].path)),
                GestureDetector(
                  onTap: () => _onImageButtonPressed(ImageSource.gallery,
                      context: context),
                  child: Container(
                    height: _width / 4,
                    width: _width / 4,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1),
                      color: Colors.grey.shade200,
                    ),
                    child: _imageFileList.isEmpty
                        ? const Center(
                            child: Text('pick a picture '),
                          )
                        : Image.file(
                            File(_imageFileList.first.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: _width / 4,
                  child: TextField(
                      controller: _controllerName,
                      maxLength: 15,
                      decoration: InputDecoration(hintText: '이름을 입력하세요.')),
                ),
                SizedBox(
                  child: TextField(
                      controller: _controllerAge,
                      maxLength: 2,
                      decoration: InputDecoration(hintText: '나이를 입력하세요.')),
                  width: _width / 4,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: _width / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: OutlinedButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black)),
                              onPressed: () => context.pop(),
                              child: const Text('취소'))),
                      Expanded(
                          child: OutlinedButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black)),
                              onPressed: () {},
                              child: const Text('확인'))),
                    ],
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) {
      print('이미지를 선택하지 않았음');
    } else {
      setState(() {
        if (_imageFileList.isNotEmpty) {
          _imageFileList.clear();
        }
        _imageFileList.add(pickedFile);
      });
    }
  }
}
