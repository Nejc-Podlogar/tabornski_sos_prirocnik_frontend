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

    final List<models.Material> materials = <models.Material>[
      models.Material(
          name: 'GSJ razpis', file: 'assets/pdfs/GSJ23_razpis.pdf', description: 'GSJ razpis'),
      models.Material(
          name: 'Morsejeva abeceda 2', file: 'morse_code.pdf', description: ''),
    ];

    return Scaffold(
        appBar: CustomAppBar(title: AppLocalizations.of(context)!.morseCodeAlphabet),
        bottomNavigationBar: CustomBottomNavigation(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.morseCodeAlphabet),
            const SizedBox(height: 40),
            const SizedBox(
                width: 300,
                child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ornare nec velit at maximus. Proin neque diam, vestibulum molestie dolor sed, pulvinar vehicula mauris. Vivamus in porta leo. Proin dignissim augue eget neque lacinia, non finibus risus pretium.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'JetBrains Mono'
                  ),
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
                        AppLocalizations.of(context)!.translator,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'JetBrains Mono'
                        )
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
                          AppLocalizations.of(context)!.exercises,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'JetBrains Mono'
                          )
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
                          AppLocalizations.of(context)!.dictionary,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'JetBrains Mono'
                          )
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
