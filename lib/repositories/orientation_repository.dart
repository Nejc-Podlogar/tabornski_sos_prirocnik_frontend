

import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class OrientationRepository {

  bool validateCombination(
      CardSwiperDirection swiperDirection,
      bool isCombinationCorrect,
      ) {

    if (swiperDirection == CardSwiperDirection.right) {
      if(isCombinationCorrect) {
        return true;
      } else {
        return false;
      }
    } else if (swiperDirection == CardSwiperDirection.left) {
      if(!isCombinationCorrect) {
        return true;
      } else {
        return false;
      }
    }

    return false;

  }


}