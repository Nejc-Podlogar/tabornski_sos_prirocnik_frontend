import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/orientation_sign.dart';
import '../../domain/value_objects/topo_group_type.dart';
import 'orientation_repository_provider.dart';

final orientationSignsProvider = FutureProvider<List<OrientationSign>>((ref) {
  final repository = ref.watch(orientationRepositoryProvider);
  return repository.getAll();
});

final orientationSignsByGroupProvider =
    FutureProvider.family<List<OrientationSign>, TopoGroupType>(
  (ref, group) {
    final repository = ref.watch(orientationRepositoryProvider);
    return repository.getByGroup(group);
  },
);
