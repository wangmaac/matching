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
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.grey.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Lottie.network(
                    'https://assets9.lottiefiles.com/packages/lf20_l4xxtfd3.json'),
              ),
              SizedBox(
                width: double.infinity,
                height: 80,
                child: ElevatedButton(
                    onPressed: () => GoRouter.of(context).pop(),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black38)),
                    child: const Center(
                      child: FittedBox(
                        child: Text(
                          'back to menu',
                          textScaleFactor: 3.5,
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
