import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matching/model/hive_model/user.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController _controllerName;
  late TextEditingController _controllerAge;

  late List<XFile> _imageFileList;

  final ImagePicker _picker = ImagePicker();

  XFile? selectImageFile;
  String urlPath = '';

  @override
  void initState() {
    _imageFileList = [];
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
                      decoration:
                          const InputDecoration(hintText: '????????? ???????????????.')),
                ),
                SizedBox(
                  child: TextField(
                    controller: _controllerAge,
                    maxLength: 2,
                    decoration:
                        const InputDecoration(hintText: '????????? ???????????????(?????????).'),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                  ),
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
                              child: const Text('??????'))),
                      Expanded(
                          child: OutlinedButton(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black)),
                              onPressed: () async {
                                if (_controllerName.text.isEmpty ||
                                    _controllerAge.text.isEmpty ||
                                    selectImageFile == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('??? ?????? ????????????.')));
                                  return;
                                } else {
                                  int id = 0;
                                  final box = Hive.box<UserModel>('user');
                                  box
                                      .put(
                                          _controllerName.text,
                                          UserModel(
                                            name: _controllerName.text,
                                            age: int.parse(_controllerAge.text),
                                            image: urlPath,
                                            jigsawAnswerList: [],
                                          ))
                                      .then((value) {
                                    GoRouter.of(context).pop();
                                    print('loading end');
                                  });
                                  print('loading start');
                                }
                              },
                              child: const Text('??????'))),
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
    selectImageFile = pickedFile;
    urlPath = selectImageFile!.path;
    if (pickedFile == null) {
      print('???????????? ???????????? ?????????');
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
