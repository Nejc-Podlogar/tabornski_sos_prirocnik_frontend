

import 'package:flutter/material.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/materials_widget.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/navigation_bottom.dart';

import '../../models/material.dart' as models;
import '../../themes/default_dark.dart';
import '../../widgets/MorseCodeCustomDisplay.dart';

class OrientationView extends StatelessWidget {
  const OrientationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<models.Material> materials = <models.Material>[
      models.Material(
          name: 'Morsejeva abeceda', file: 'morse_code.pdf', description: ''),
      models.Material(
          name: 'Morsejeva abeceda 2', file: 'morse_code.pdf', description: ''),
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Orientacija'),
      bottomNavigationBar: CustomBottomNavigation(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text('Orientacija'),
            const SizedBox(height: 40),
            const SizedBox(
                width: 300,
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ornare nec velit at maximus. Proin neque diam, vestibulum molestie dolor sed, pulvinar vehicula mauris. Vivamus in porta leo. Proin dignissim augue eget neque lacinia, non finibus risus pretium.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'JetBrains Mono'),
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Handle your onTap action here
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.g_translate_outlined,
                          size: MediaQuery.of(context).size.width * 0.14,
                          color: Colors.white,
                        ),
                        const Text(
                          'Karte',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: IconButton(
                    icon: const Icon(Icons.school_outlined),
                    iconSize: MediaQuery.of(context).size.width * 0.14,
                    color: Colors.white,
                    onPressed: () {  },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: IconButton(
                    icon: const Icon(Icons.school_outlined),
                    iconSize: MediaQuery.of(context).size.width * 0.14,
                    color: Colors.white,
                    onPressed: () {  },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: IconButton(
                    icon: const Icon(Icons.g_translate_outlined),
                    iconSize: MediaQuery.of(context).size.width * 0.14,
                    color: Colors.white,
                    onPressed: () {  },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: IconButton(
                    icon: const Icon(Icons.school_outlined),
                    iconSize: MediaQuery.of(context).size.width * 0.14,
                    color: Colors.white,
                    onPressed: () {  },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: IconButton(
                    icon: const Icon(Icons.school_outlined),
                    iconSize: MediaQuery.of(context).size.width * 0.14,
                    color: Colors.white,
                    onPressed: () {  },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: IconButton(
                    icon: const Icon(Icons.g_translate_outlined),
                    iconSize: MediaQuery.of(context).size.width * 0.14,
                    color: Colors.white,
                    onPressed: () {  },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: IconButton(
                    icon: const Icon(Icons.school_outlined),
                    iconSize: MediaQuery.of(context).size.width * 0.14,
                    color: Colors.white,
                    onPressed: () {  },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: primaryCardTheme.color,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: MorseCodeCustomDisplay(morseCodeText: '...', color: Colors.white),),
                ),
              ],
            ),
            const SizedBox(height: 40),
            MaterialsWidget(materials: materials)
          ],
        ),
      )
    );
  }
}