import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../domain/entities/orientation_sign.dart';
import '../../domain/value_objects/topo_group_type.dart';
import '../providers/orientation_signs_provider.dart';
import '../widgets/orientation_sign_card.dart';
import '../widgets/topo_group_chip.dart';

class OrientationReferenceScreen extends ConsumerStatefulWidget {
  const OrientationReferenceScreen({super.key});

  @override
  ConsumerState<OrientationReferenceScreen> createState() =>
      _OrientationReferenceScreenState();
}

class _OrientationReferenceScreenState
    extends ConsumerState<OrientationReferenceScreen> {
  TopoGroupType? _selectedGroup;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      final categoryId =
          GoRouterState.of(context).pathParameters['categoryId'] ?? '';
      _selectedGroup = _parseGroup(categoryId);
    }
  }

  static TopoGroupType? _parseGroup(String categoryId) {
    try {
      return TopoGroupType.values.firstWhere((g) => g.name == categoryId);
    } catch (_) {
      return null;
    }
  }

  String get _title {
    return _selectedGroup?.label ?? 'Topografija';
  }

  @override
  Widget build(BuildContext context) {
    final signsAsync = _selectedGroup != null
        ? ref.watch(orientationSignsByGroupProvider(_selectedGroup!))
        : ref.watch(orientationSignsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: _title,
        showBackButton: true,
        onSettingsPressed: () => context.goNamed(RouteNames.settings),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Group filter chips
          SizedBox(
            height: 56,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
                vertical: AppSpacing.xs,
              ),
              itemCount: TopoGroupType.values.length + 1,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: AppSpacing.sm),
              itemBuilder: (_, index) {
                if (index == 0) {
                  return _AllChip(
                    isSelected: _selectedGroup == null,
                    onTap: () => setState(() => _selectedGroup = null),
                  );
                }

                final group = TopoGroupType.values[index - 1];
                return TopoGroupChip(
                  topoGroupType: group,
                  isSelected: _selectedGroup == group,
                  onTap: () => setState(() => _selectedGroup = group),
                );
              },
            ),
          ),
          const Divider(color: AppColors.surface, height: 1),

          // Sign grid
          Expanded(
            child: signsAsync.when(
              data: (signs) => _SignGrid(signs: signs),
              loading: () => const Center(
                child:
                    CircularProgressIndicator(color: AppColors.primary),
              ),
              error: (e, _) => Center(
                child: Text(
                  'Napaka pri nalaganju: $e',
                  style: AppTypography.body
                      .copyWith(color: AppColors.danger),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AllChip extends StatelessWidget {
  const _AllChip({required this.isSelected, required this.onTap});

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
              'Vsi znaki',
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

class _SignGrid extends StatelessWidget {
  const _SignGrid({required this.signs});

  final List<OrientationSign> signs;

  @override
  Widget build(BuildContext context) {
    if (signs.isEmpty) {
      return Center(
        child: Text(
          'Ni znakov za to kategorijo.',
          style: AppTypography.body.copyWith(color: AppColors.textTertiary),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.base),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 0.75,
      ),
      itemCount: signs.length,
      itemBuilder: (_, index) => OrientationSignCard(sign: signs[index]),
    );
  }
}
