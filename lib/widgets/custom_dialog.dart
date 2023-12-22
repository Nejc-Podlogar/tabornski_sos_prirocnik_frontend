
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogNoButtons extends StatelessWidget {

  final String title;
  final String content;
  final IconData icon;
  final Duration duration;

  const CustomDialogNoButtons({Key? key, required this.title, required this.content, required this.icon, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(duration, () {
      Navigator.of(context).pop();
    });

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Icon(icon, color: Colors.black, size: 36),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JetBrains Mono',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}