
enum OrientationFilterType {
  images,
  text
}

enum OrientationTopoCategory {
  geodetske_tocke,
  morje_in_morska_obala,
  naselja_in_objekti,
  promet,
  rastje_in_vrste_tal,
  relief,
  vodovje,
  meje_in_ograje
}

enum OrientationInterfaceType {
  cards
}

class OrientationExerciseParams {
  final OrientationFilterType filterType;
  final List<OrientationTopoCategory> topoCategories;
  final int numberOfIterations;

  Map<String, dynamic> toJson() => {
    "topoCategories": topoCategories.map((OrientationTopoCategory e) => e.name.toString()).toList(),
    "numberOfIterations": numberOfIterations
  };

  OrientationExerciseParams({required this.filterType, required this.topoCategories, required this.numberOfIterations});
}

class OrientationExercise {
  List<String> names;
  List<String> images;
  List<bool> areCombinationsCorrect;

  OrientationExercise({required this.names, required this.images, required this.areCombinationsCorrect});

  OrientationExercise copyWith({List<String>? names, List<String>? images, List<bool>? correctAnswers}) {
    return OrientationExercise(
      names: names ?? this.names,
      images: images ?? this.images,
      areCombinationsCorrect: correctAnswers ?? this.areCombinationsCorrect
    );
  }

}