import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/generated/l10n.dart';
import 'package:tabornski_sos_prirocnik_frontend/routing/route_definitions.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/materials_widget.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/navigation_bottom.dart';
import '../../models/models.dart' as models;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MorseCodeView extends StatelessWidget {
  const MorseCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final AppLocalizations localizations = AppLocalizations.of(context)!;

    final List<models.Material> materials = <models.Material>[
      models.Material(
          name: 'GSJ razpis', file: 'assets/pdfs/GSJ23_razpis.pdf', description: 'GSJ razpis'),
      models.Material(
          name: 'Morsejeva abeceda 2', file: 'morse_code.pdf', description: ''),
    ];

    return Scaffold(
        appBar: CustomAppBar(title: localizations.morseCodeAlphabet),
        bottomNavigationBar: CustomBottomNavigation(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
                localizations.morseCodeAlphabet,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            SizedBox(
                width: 300,
                child: Text(
                    localizations.morseCodeDescription,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.g_translate_outlined),
                        iconSize: MediaQuery.of(context).size.width * 0.12,
                        color: Colors.white,
                        onPressed: () {
                          context.goNamed(RouteNames.morseCodeTranslator);
                        },
                      ),
                      Text(
                        localizations.translator,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white)
                      )
                    ]),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.school_outlined),
                          iconSize: MediaQuery.of(context).size.width * 0.12,
                          color: Colors.white,
                          onPressed: () => context.goNamed(RouteNames.morseCodeLearningSelector)
                      ),
                      Text(
                          localizations.exercises,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white)
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.menu_book_outlined),
                        iconSize: MediaQuery.of(context).size.width * 0.12,
                        color: Colors.white,
                        onPressed: () {
                          context.goNamed(RouteNames.morseCodeMaterials);
                        },
                      ),
                      Text(
                          localizations.dictionary,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white)
                      )
                    ],
                  ),
                ),
              ]
            ),
            const SizedBox(height: 40),
            MaterialsWidget(key: key, materials: materials)
          ],
        ));
  }
}
