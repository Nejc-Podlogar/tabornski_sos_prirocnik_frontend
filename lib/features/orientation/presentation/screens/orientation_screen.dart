import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/section_action_tile.dart';
import '../../domain/value_objects/topo_group_type.dart';
import '../widgets/topo_group_chip.dart';

class OrientationScreen extends ConsumerWidget {
  const OrientationScreen({super.key});

  static const _categoryGroups = [
    TopoGroupType.geodetskeTocke,
    TopoGroupType.mejeInOgraje,
    TopoGroupType.morjeInMorskaObala,
    TopoGroupType.naseljaInObjekti,
    TopoGroupType.prometKomunikacije,
    TopoGroupType.rastjeInVrsteTal,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: 'Orientacija',
        onSettingsPressed: () => context.goNamed(RouteNames.settings),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              context.goNamed(RouteNames.home);
            case 1:
              context.goNamed(RouteNames.morse);
            case 2:
              context.goNamed(RouteNames.semaphore);
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero banner
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primaryDark, AppColors.surface],
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ORIENTACIJA',
                          style: AppTypography.overline.copyWith(
                            color: AppColors.primaryLight,
                          ),
                        ),
                        Text(
                          'TOPOGRAFIJA',
                          style: AppTypography.screenTitle.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Znaki • Karte • Tereni',
                          style: AppTypography.overline.copyWith(
                            color: AppColors.primaryLight,
                            fontSize: 13,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedCompass,
                    color: AppColors.primary,
                    size: 56,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Wide Topografija reference tile
            SectionActionTile(
              icon: HugeIcons.strokeRoundedMapsSquare01,
              title: 'Topografija',
              subtitle: 'Vsi topografski znaki',
              onTap: () => context.goNamed(
                RouteNames.orientationReference,
                pathParameters: {'categoryId': 'topografija'},
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // 2×3 category grid
            Text(
              'KATEGORIJE',
              style: AppTypography.overline
                  .copyWith(color: AppColors.textTertiary),
            ),
            const SizedBox(height: AppSpacing.sm),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: 2.2,
              children: _categoryGroups.map((group) {
                return _CategoryTile(
                  group: group,
                  onTap: () => context.goNamed(
                    RouteNames.orientationReference,
                    pathParameters: {'categoryId': group.name},
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),

            // Učenje tile
            SectionActionTile(
              icon: HugeIcons.strokeRoundedBook01,
              title: 'Učenje',
              subtitle: 'Vaje prepoznavanja znakov',
              onTap: () =>
                  context.goNamed(RouteNames.orientationExerciseSelector),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.group, required this.onTap});

  final TopoGroupType group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primaryDark, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                group.label,
                style: AppTypography.body.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight01,
              color: AppColors.textTertiary,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
