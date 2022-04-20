import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final error;
  const ErrorPage({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(child: Text(error.toString())),
    );
  }
}
