import 'dart:math';

import '../entities/orientation_sign.dart';
import '../repositories/i_orientation_repository.dart';
import '../value_objects/topo_group_type.dart';

class GetOrientationExerciseUseCase {
  const GetOrientationExerciseUseCase(this._repository);

  final IOrientationRepository _repository;

  static final _random = Random();

  Future<List<OrientationSign>> call(
    Set<TopoGroupType> selectedGroups,
    int count,
  ) async {
    final signs = await _repository.getByGroups(selectedGroups);
    signs.shuffle(_random);

    final selected = signs.take(count).toList();

    return selected.map((sign) {
      // 50% chance to swap this sign's name with a different sign's name,
      // creating an incorrect image–name combination for the exercise.
      if (!_random.nextBool()) return sign;

      final others = signs.where((s) => s.id != sign.id).toList();
      if (others.isEmpty) return sign;

      final donor = others[_random.nextInt(others.length)];
      return sign.copyWith(name: donor.name);
    }).toList();
  }
}
