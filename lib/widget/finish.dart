import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class FinishWidget extends StatelessWidget {
  final dynamic vm;

  const FinishWidget({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: vm.complete,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: SizedBox(
              width: 500,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Lottie.network(
                  'https://assets9.lottiefiles.com/packages/lf20_l4xxtfd3.json'),
            ),
          ),
          ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/menu'),
              child: const Center(
                  child: FittedBox(
                child: Text(
                  'back',
                ),
              )))
        ],
      ),
    );
    ;
  }
}
