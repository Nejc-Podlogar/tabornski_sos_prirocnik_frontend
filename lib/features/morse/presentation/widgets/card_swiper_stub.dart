// Web stub for flutter_card_swiper.
// CardSwiper is guarded by a kIsWeb check in learning_cards_widget.dart
// and will never be rendered on web; this stub allows web compilation.
import 'package:flutter/material.dart';

enum CardSwiperDirection { none, left, right, top, bottom }

class CardSwiper extends StatelessWidget {
  const CardSwiper({
    super.key,
    required this.cardsCount,
    required this.cardBuilder,
    this.numberOfCardsDisplayed = 1,
    this.onSwipe,
  });

  final int cardsCount;
  final Widget? Function(BuildContext, int, int, int) cardBuilder;
  final int numberOfCardsDisplayed;
  final bool Function(int, int, CardSwiperDirection)? onSwipe;

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
