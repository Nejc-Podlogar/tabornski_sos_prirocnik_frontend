
import 'package:flutter/material.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';

import '../../widgets/navigation_bottom.dart';

class MorseCodeLearning extends StatefulWidget {
  const MorseCodeLearning({Key? key}) : super(key: key);

  @override
  _MorseCodeLearningState createState() => _MorseCodeLearningState();
}

class _MorseCodeLearningState extends State<MorseCodeLearning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Morse Code Learning', enablePopButton: true),
      bottomNavigationBar: CustomBottomNavigation(),
      body: const Padding(
        padding: EdgeInsets.fromLTRB(8, 20, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Morse Code Learning'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'From the option below, select the desired learning case for morse code.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'JetBrains Mono',
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1,
              color: Colors.black,
            ),

          ],
        ),
      ),
    );
  }
}