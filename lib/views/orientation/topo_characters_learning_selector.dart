import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/api/orientation_api_service.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/orientation_exercise_bloc/orientation_exercise_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/models/orientation.dart';
import 'package:tabornski_sos_prirocnik_frontend/repositories/orientation_repository.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/navigation_bottom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../generated/l10n.dart';
import '../../routing/route_definitions.dart';

class TopoCharactersLearning extends StatefulWidget {
  const TopoCharactersLearning({Key? key}) : super(key: key);

  @override
  _TopoCharactersLearningState createState() => _TopoCharactersLearningState();
}

class _TopoCharactersLearningState extends State<TopoCharactersLearning> {
  OrientationFilterType? _selectedLearningType;
  List<OrientationTopoCategory> _selectedTopoCategory = [];
  //OrientationInterfaceType _selectedLearningInteractionType = OrientationInterfaceType.cards;
  int? _selectedNumberOfRepetitions;



  Widget _buildCategoryChip(OrientationTopoCategory category, S localization) {
    return FilterChip(
        showCheckmark: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        label: Text(
            localization.topoCategory(category),
          style: TextStyle(
            color: _selectedTopoCategory.contains(category) ? Colors.white : Theme.of(context).chipTheme.labelStyle!.color
          )
        ),
        selected: _selectedTopoCategory.contains(category),

        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedTopoCategory.add(category);
            } else {
              _selectedTopoCategory.remove(category);
            }
          });
        },
    );


  }


  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context);

    return Scaffold(
      appBar: CustomAppBar(title: localizations.topography, enablePopButton: true,),
      bottomNavigationBar: CustomBottomNavigation(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  localizations.topographyLearning,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  '${localizations.learningType}:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ChoiceChip(
                    showCheckmark: false,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    label: SizedBox(
                        width: 90,
                        height: 16,
                        child: Center(child: Text(localizations.topoImages))),
                    selected:
                    _selectedLearningType == OrientationFilterType.images,
                    labelStyle: TextStyle(
                      color: _selectedLearningType ==
                          OrientationFilterType.images
                          ? Colors.white
                          : Theme.of(context).chipTheme.labelStyle!.color,
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedLearningType =
                        selected ? OrientationFilterType.images : null;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    showCheckmark: false,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    label: SizedBox(
                        width: 90,
                        height: 16,
                        child: Center(child: Text(localizations.topoText))),
                    selected:
                    _selectedLearningType == OrientationFilterType.text,
                    labelStyle: TextStyle(
                      color: _selectedLearningType ==
                          OrientationFilterType.text
                          ? Colors.white
                          : Theme.of(context).chipTheme.labelStyle!.color,
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedLearningType =
                        selected ? OrientationFilterType.text : null;
                      });
                    },
                  )
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                    '${localizations.topoCategories}:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8.0,
                runSpacing: 4.0,
                children: OrientationTopoCategory.values.map((category) => _buildCategoryChip(category, localizations)).toList(),
              ),
              const SizedBox(height: 20),
              /*Center(
                child: Text('${localizations.userInterface}:'),
              ),
              const SizedBox(height: 10),
              Center(
                child: ChoiceChip(
                  label: SizedBox(
                      width: 51,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/icons/card_swipe_icon.svg',
                            height: 60,
                            width: 80,
                          ),
                          Text(localizations.cardSwipe),
                        ],
                      )),
                  showCheckmark: false,
                  selected: _selectedLearningInteractionType ==
                      OrientationInterfaceType.cards,
                  labelStyle: TextStyle(
                    color: _selectedLearningInteractionType ==
                        OrientationInterfaceType.cards
                        ? Colors.white
                        : Theme.of(context).chipTheme.labelStyle!.color,
                  ),
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedLearningInteractionType =
                      (selected ? OrientationInterfaceType.cards : null)!;
                    });
                  },
                ),
              )*/
              Center(
                child: Text(
                    '${localizations.amountOfRepetitions}:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 20,
                  runSpacing: 1,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    ChoiceChip(
                      showCheckmark: false,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      label: const SizedBox(
                          width: 26,
                          height: 16,
                          child: Center(child: Text('1'))),
                      selected: _selectedNumberOfRepetitions ==
                          1,
                      labelStyle: TextStyle(
                        color: _selectedNumberOfRepetitions ==
                            1
                            ? Colors.white
                            : Theme.of(context).chipTheme.labelStyle!.color,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedNumberOfRepetitions =
                          selected ? 1 : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      showCheckmark: false,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      label: const SizedBox(
                          width: 26,
                          height: 16,
                          child: Center(child: Text('5'))),
                      selected: _selectedNumberOfRepetitions ==
                          5,
                      labelStyle: TextStyle(
                        color: _selectedNumberOfRepetitions ==
                            5
                            ? Colors.white
                            : Theme.of(context).chipTheme.labelStyle!.color,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedNumberOfRepetitions =
                          selected ? 5 : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      showCheckmark: false,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      label: const SizedBox(
                          width: 26,
                          height: 16,
                          child: Center(child: Text('10'))),
                      selected: _selectedNumberOfRepetitions ==
                          10,
                      labelStyle: TextStyle(
                        color: _selectedNumberOfRepetitions ==
                            10
                            ? Colors.white
                            : Theme.of(context).chipTheme.labelStyle!.color,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedNumberOfRepetitions =
                          selected ? 10 : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      showCheckmark: false,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      label: const SizedBox(
                          width: 26,
                          height: 16,
                          child: Center(child: Text('20'))),
                      selected: _selectedNumberOfRepetitions ==
                          20,
                      labelStyle: TextStyle(
                        color: _selectedNumberOfRepetitions ==
                            20
                            ? Colors.white
                            : Theme.of(context).chipTheme.labelStyle!.color,
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedNumberOfRepetitions =
                          selected ? 20 : null;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () async {

                  if( _selectedNumberOfRepetitions != null && _selectedTopoCategory.isNotEmpty && _selectedLearningType != null) {
                    dynamic response = await OrientationApiService().getExercise(_selectedNumberOfRepetitions!, _selectedTopoCategory);

                    BlocProvider.of<OrientationExerciseBloc>(context).add(OrientationExerciseStart(names: response.names, images: response.images, areCombinationsCorrect: response.areCombinationsCorrect, correctAnswers: []));

                    context.pushNamed(RouteNames.orientationLearning, extra: {'params': OrientationExerciseParams(
                      filterType: _selectedLearningType!,
                      topoCategories: _selectedTopoCategory,
                      numberOfIterations: _selectedNumberOfRepetitions!,
                    )});

                  }

                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.85, 50),
                ),
                child: Text(localizations.beginLearning),
              ),
              const SizedBox(height: 20),
            ],
          )
        ),
      ),
    );
  }
}