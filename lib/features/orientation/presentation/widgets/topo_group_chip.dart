import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../domain/value_objects/topo_group_type.dart';

extension TopoGroupTypeLabel on TopoGroupType {
  String get label => switch (this) {
        TopoGroupType.geodetskeTocke => 'Geodetske točke',
        TopoGroupType.mejeInOgraje => 'Meje in ograje',
        TopoGroupType.morjeInMorskaObala => 'Morje in obala',
        TopoGroupType.naseljaInObjekti => 'Naselja in objekti',
        TopoGroupType.prometKomunikacije => 'Promet',
        TopoGroupType.rastjeInVrsteTal => 'Rastje',
        TopoGroupType.relief => 'Relief',
        TopoGroupType.vodovje => 'Vodovje',
      };
}

class TopoGroupChip extends StatelessWidget {
  const TopoGroupChip({
    super.key,
    required this.topoGroupType,
    required this.isSelected,
    required this.onTap,
  });

  final TopoGroupType topoGroupType;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 48,
        child: Center(
          child: Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: isSelected
                  ? null
                  : Border.all(color: AppColors.textTertiary, width: 1),
            ),
            alignment: Alignment.center,
            child: Text(
              topoGroupType.label,
              style: AppTypography.filterChip.copyWith(
                color: isSelected
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
