import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/icons/custom_icons_icons.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_dialog.dart';
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
          name: 'Orientacija - celota', file: 'assets/pdfs/Bodi_pripravljen_2.pdf', description: ''),
    ];

    return Scaffold(
        appBar: const CustomAppBar(title: 'Orientacija'),
        bottomNavigationBar: CustomBottomNavigation(),
        body: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                Text(localisations.orientation, style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 30),
                SizedBox(
                    width: 300,
                    child: Text(
                      localisations.orientationDescription,
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
                                        builder: (context) => const PDFScreen(assetPath: 'assets/pdfs/topografski-znaki-za-dtk25.pdf', title: 'Topografski znaki za DTK 25'),
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
                        icon: const Icon(Icons.map_outlined),
                        iconSize: MediaQuery.of(context).size.width * 0.14,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PDFScreen(assetPath: 'assets/pdfs/orientation/orientacija_karta.pdf', title: 'Orientacija - karta'),
                            ),
                          );
                        },
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
                        icon: const Icon(Icons.star_border_outlined),
                        iconSize: MediaQuery.of(context).size.width * 0.14,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PDFScreen(assetPath: 'assets/pdfs/orientation/orientacija_zvezde.pdf', title: 'Orientacija - zvezde'),
                            ),
                          );
                        },
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
                        icon: const Icon(Icons.map_sharp),
                        iconSize: MediaQuery.of(context).size.width * 0.14,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PDFScreen(assetPath: 'assets/pdfs/orientation/orientacija_kompas.pdf', title: 'Orientacija - kompas'),
                            ),
                          );
                        },
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
                        icon: const Icon(Icons.forest_outlined),
                        iconSize: MediaQuery.of(context).size.width * 0.14,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PDFScreen(assetPath: 'assets/pdfs/orientation/orientacija_splosno.pdf', title: 'Orientacija - splošno'),
                            ),
                          );
                        },
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
                        icon: const Icon(Icons.directions_walk_outlined),
                        iconSize: MediaQuery.of(context).size.width * 0.14,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PDFScreen(assetPath: 'assets/pdfs/orientation/orientacija_navigacija_azimuti.pdf', title: 'Orientacija - splošno'),
                            ),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialogNoButtons(
                            duration: Duration(seconds: 5),
                            title: localisations.comingSoon,
                            content: localisations.orientationMoreComingSoon,
                            icon: Icons.info, // Added the required 'icon' parameter
                          ),
                        );
                      },
                      child: Container(
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
                    )
                  ],
                ),
                const SizedBox(height: 40),
                MaterialsWidget(materials: materials)
              ],
            ),
          ),
        ));
  }
}
