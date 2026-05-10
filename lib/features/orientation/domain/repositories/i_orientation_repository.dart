import '../entities/orientation_sign.dart';
import '../value_objects/topo_group_type.dart';

abstract interface class IOrientationRepository {
  Future<List<OrientationSign>> getAll();

  Future<List<OrientationSign>> getByGroup(TopoGroupType group);

  Future<List<OrientationSign>> getByGroups(Set<TopoGroupType> groups);
}
