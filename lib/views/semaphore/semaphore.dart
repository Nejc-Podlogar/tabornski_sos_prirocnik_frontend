import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/materials_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/material.dart' as models;
import '../../routing/route_definitions.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/navigation_bottom.dart';

class SemaphoreView extends StatelessWidget {
  const SemaphoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;

    final List<models.Material> materials = <models.Material>[
      models.Material(
          name: 'GSJ razpis',
          file: 'assets/pdfs/GSJ23_razpis.pdf',
          description: 'GSJ razpis'),
      models.Material(
          name: 'Semaforjeva abeceda 2',
          file: 'semaphore.pdf',
          description: ''),
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Morsejeva abeceda'),
      bottomNavigationBar: CustomBottomNavigation(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              localizations.semaphoreAlphabet,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            SizedBox(
                width: 300,
                child: Text(
                  localizations.semaphoreDescription,
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
                          context.goNamed(RouteNames.semaphoreTranslator);
                        },
                      ),
                      Text(localizations.translator,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Colors.white))
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.width * 0.25,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.school_outlined),
                            iconSize: MediaQuery.of(context).size.width * 0.12,
                            color: Colors.white,
                            onPressed: () {
                              // Your onPressed code here
                            },
                          ),
                          Text(
                            localizations.exercises,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.width * 0.25,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E3330).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          localizations.comingSoon,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
                        context.goNamed(RouteNames.semaphoreMaterials);
                      },
                    ),
                    Text(localizations.dictionary,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: Colors.white))
                  ],
                ),
              ),
            ]),
            const SizedBox(height: 40),
            MaterialsWidget(key: key, materials: materials)
          ],
        ),
      ),
    );
  }
}
