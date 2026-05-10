import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/topo_group_type.dart';

part 'orientation_sign.freezed.dart';

@freezed
class OrientationSign with _$OrientationSign {
  const factory OrientationSign({
    required int id,
    required String name,
    required String imageLoc,
    required TopoGroupType topoGroupType,
  }) = _OrientationSign;
}
