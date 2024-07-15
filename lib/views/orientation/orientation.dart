import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/icons/custom_icons_icons.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/materials_widget.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/navigation_bottom.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/pdf_custom_viewer.dart';

import '../../generated/l10n.dart';
import '../../models/material.dart' as models;
import '../../routing/route_definitions.dart';
import '../../themes/default_dark.dart';
import '../../widgets/MorseCodeCustomDisplay.dart';

class OrientationView extends StatelessWidget {
  const OrientationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S localisations = S.of(context);

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
              Text(localisations.orientation, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 30),
              SizedBox(
                  width: 300,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ornare nec velit at maximus. Proin neque diam, vestibulum molestie dolor sed, pulvinar vehicula mauris. Vivamus in porta leo. Proin dignissim augue eget neque lacinia, non finibus risus pretium.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium
                  )),
              const SizedBox(height: 20),
              Center(
                child: Container(
                    margin: const EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.width * 0.25,
                    width: MediaQuery.of(context).size.width * 0.80,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.school_outlined),
                                iconSize: MediaQuery.of(context).size.width * 0.12,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PDFScreen(path: 'assets/pdfs/topografski-znaki-za-dtk25.pdf', title: 'Topografski znaki za DTK 25', isLocal: true,),
                                    ),
                                  );
                                },
                              ),
                              Text(
                                localisations.topography,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'JetBrains Mono',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 70,
                              width: 4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: IconButton(
                                icon: const Icon(CustomIcons.brain_1, color: Colors.white),
                                iconSize: MediaQuery.of(context).size.width * 0.10,
                                onPressed: () => context.goNamed(RouteNames.orientationLearningSelector),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
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
                      onPressed: () {},
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
                      onPressed: () {},
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
                      onPressed: () {},
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
                      onPressed: () {},
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
                      onPressed: () {},
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
                      child: MorseCodeCustomDisplay(
                          morseCodeText: '...', color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              MaterialsWidget(materials: materials)
            ],
          ),
        ));
  }
}
