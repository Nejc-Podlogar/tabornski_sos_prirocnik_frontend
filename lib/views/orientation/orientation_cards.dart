import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:tabornski_sos_prirocnik_frontend/blocs/orientation_exercise_bloc/orientation_exercise_bloc.dart';
import 'package:tabornski_sos_prirocnik_frontend/models/orientation.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/custom_app_bar.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/navigation_bottom.dart';
import 'package:tabornski_sos_prirocnik_frontend/widgets/progress_dots.dart';

import '../../generated/l10n.dart';

class OrientationScreenCards extends StatefulWidget {
  final OrientationExerciseParams params;
  const OrientationScreenCards({Key? key, required this.params})
      : super(key: key);

  @override
  _OrientationScreenCardsState createState() => _OrientationScreenCardsState();
}

class _OrientationScreenCardsState extends State<OrientationScreenCards> {
  final CardSwiperController cardSwiperController = CardSwiperController();


  List<Widget> createCards(
      BuildContext context, List<String> names, List<String> images) {
    List<Widget> cards = [];

    for (int i = 0; i < names.length; i++) {
      cards.add(
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(color: const Color(0x00000025), width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFB2B39C),
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: (widget.params.filterType ==
                                  OrientationFilterType.images)
                              ? 100
                              : MediaQuery.of(context).size.height * 0.25,
                          maxHeight: MediaQuery.of(context).size.height * 0.35,
                        ),
                        child: IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                  child: widget.params.filterType ==
                                          OrientationFilterType.images
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: Image.asset(images[i].trim())),
                                          ),
                                        )
                                      : Text(
                                          names[i],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                      child: Center(
                          child: widget.params.filterType ==
                                  OrientationFilterType.images
                              ? Text(
                                  names[i],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelLarge,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Image.asset(images[i].trim())),
                                ))),
                ],
              ),
            )),
      );
    }

    return cards;
  }

  void displayBottomSheet(BuildContext context, S localizations, OrientationExerciseState state) {

    showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(25)),
        ),
        isDismissible: false,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  localizations.endOfExercise,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                ProgressDots(
                    correctAnswers: state.correctAnswers ?? [],
                    exerciseSize: state.names?.length ?? 0),
                const SizedBox(height: 20),
                SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextButton(
                        onPressed: () {
                          BlocProvider.of<OrientationExerciseBloc>(context)
                              .add(OrientationExerciseNext());
                          context.pop(context);
                          context.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          localizations.finishExercise,
                          style: const TextStyle(color: Colors.white),
                        )))
              ],
            ),
          );
        });

  }

  @override
  Widget build(BuildContext context) {
    final S localisations = S.of(context);
    return Scaffold(
      appBar:
          const CustomAppBar(title: 'Orientation Cards', enablePopButton: true),
      bottomNavigationBar: CustomBottomNavigation(),
      body: BlocBuilder<OrientationExerciseBloc, OrientationExerciseState>(
        buildWhen: (previous, current) {
          if (current is OrientationExerciseStart) {
            return true;
          }
          return false;
        },
        builder: (BuildContext context, OrientationExerciseState state) {
          final names = state.names;
          final images = state.images;

          final cards = createCards(context, names!, images!);

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.60,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: CardSwiper(
                        cardsCount: cards.length,
                        initialIndex: 0,
                        isLoop: false,
                        numberOfCardsDisplayed: names.length == 1 ? 1 : 2,
                        controller: cardSwiperController,
                        allowedSwipeDirection:
                        const AllowedSwipeDirection.only(left: true, right: true),
                        cardBuilder:
                            (context, index, percentThresholdX, percentThresholdY) =>
                        cards[index],
                        onSwipe: (previousIndex, index, swipeDirection) {
                          if (swipeDirection == CardSwiperDirection.right) {
                            BlocProvider.of<OrientationExerciseBloc>(context).add(OrientationExerciseValidate(
                                CardSwiperDirection.right,
                              indexOfValueToCompare: previousIndex,
                                ));
                            return true;
                          } else if (swipeDirection == CardSwiperDirection.left) {
                            BlocProvider.of<OrientationExerciseBloc>(context).add(OrientationExerciseValidate(
                                CardSwiperDirection.left,
                                indexOfValueToCompare: previousIndex,));
                            return true;


                          }
                          return false;
                        },
                        onEnd: () {

                          // get the bloc state
                          final stateCurrent = BlocProvider.of<OrientationExerciseBloc>(context).state;

                          displayBottomSheet(context, localisations, stateCurrent);

                        },
                        onUndo: (previousIndex, index, direction) {
                          BlocProvider.of<OrientationExerciseBloc>(context).add(UndoPreviousAnswer());
                          return true;
                        }
                    )),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                      'Progress:'
                  ),
                ),
              ),
              BlocBuilder<OrientationExerciseBloc, OrientationExerciseState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: ProgressDots(correctAnswers: state.correctAnswers ??  [], exerciseSize: names.length),
                  );
                },
              ),
              Expanded(
                child: Center(
                  child: Wrap(
                    spacing: 25.0,
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(
                                style: BorderStyle.solid,
                                width: 3,
                                color: Theme.of(context).primaryColor)),
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.close_rounded,
                                color: Theme.of(context).primaryColor, size: 50),
                            onPressed: () => cardSwiperController
                                .swipe(CardSwiperDirection.left),
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0x4D656839),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: const Icon(Icons.rotate_left_rounded,
                                color: Colors.white, size: 24),
                            onPressed: () => cardSwiperController.undo(),
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: IconButton(
                            icon: const Icon(Icons.check_rounded,
                                color: Colors.white, size: 50),
                            onPressed: () => cardSwiperController
                                .swipe(CardSwiperDirection.right),
                          ),
                        ),
                      ),
                      /*TextButton(
                    onPressed: cardSwiperController.undo,
                    child: const Icon(Icons.rotate_left),
                  ),*/
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
