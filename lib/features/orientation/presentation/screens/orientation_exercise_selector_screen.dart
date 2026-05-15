import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/domain/value_objects/exercise_enums.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../../core/widgets/filter_chip_row.dart';
import '../../../../core/widgets/primary_cta_button.dart';
import '../../../../core/widgets/segmented_control.dart';
import '../../domain/value_objects/topo_group_type.dart';
import '../providers/orientation_exercise_provider.dart';
import '../widgets/topo_group_chip.dart';

/// Shared provider so [OrientationExerciseScreen] can read the interaction type
/// chosen in the selector without needing a route extra.
final orientationInteractionTypeProvider =
    StateProvider<InteractionType>((ref) => InteractionType.cards);

class OrientationExerciseSelectorScreen extends ConsumerStatefulWidget {
  const OrientationExerciseSelectorScreen({super.key});

  @override
  ConsumerState<OrientationExerciseSelectorScreen> createState() =>
      _OrientationExerciseSelectorScreenState();
}

class _OrientationExerciseSelectorScreenState
    extends ConsumerState<OrientationExerciseSelectorScreen> {
  var _selectedGroups = <TopoGroupType>{TopoGroupType.relief};
  int _modeIndex = 0;
  int _repetitionIndex = 1;

  static const _counts = [1, 5, 10, 20];

  InteractionType get _interactionType =>
      _modeIndex == 0 ? InteractionType.cards : InteractionType.keyboard;

  bool get _canStart => _selectedGroups.isNotEmpty;

  Future<void> _start() async {
    ref.read(orientationInteractionTypeProvider.notifier).state =
        _interactionType;

    await ref.read(orientationExerciseProvider.notifier).startExercise(
          _selectedGroups,
          _counts[_repetitionIndex],
          _interactionType,
        );

    if (mounted) context.pushNamed(RouteNames.orientationExerciseSession);
  }

  void _toggleGroup(TopoGroupType group) {
    setState(() {
      if (_selectedGroups.contains(group)) {
        if (_selectedGroups.length > 1) {
          _selectedGroups = Set.from(_selectedGroups)..remove(group);
        }
      } else {
        _selectedGroups = Set.from(_selectedGroups)..add(group);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: 'Nastavi Urjenje',
        showBackButton: true,
        onSettingsPressed: () => context.goNamed(RouteNames.settings),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.base),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SectionLabel('KATEGORIJE ZNAKOV'),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: TopoGroupType.values.map((group) {
                return TopoGroupChip(
                  topoGroupType: group,
                  isSelected: _selectedGroups.contains(group),
                  onTap: () => _toggleGroup(group),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.xl),

            _SectionLabel('NAČIN VADBE'),
            const SizedBox(height: AppSpacing.sm),
            SegmentedControl(
              options: const ['Swipe', 'Tipkovnica'],
              selectedIndex: _modeIndex,
              onChanged: (i) => setState(() => _modeIndex = i),
            ),
            const SizedBox(height: AppSpacing.xl),

            _SectionLabel('ŠTEVILO PONOVITEV'),
            const SizedBox(height: AppSpacing.sm),
            FilterChipRow(
              options: _counts.map((c) => c.toString()).toList(),
              selectedIndex: _repetitionIndex,
              onSelected: (i) => setState(() => _repetitionIndex = i),
            ),
            const SizedBox(height: AppSpacing.xxxl),

            PrimaryCtaButton(
              label: 'Začni Urjenje',
              onPressed: _canStart ? _start : null,
            ),

            if (!_canStart) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Izberi vsaj eno kategorijo.',
                style: AppTypography.caption
                    .copyWith(color: AppColors.danger),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.overline.copyWith(color: AppColors.textTertiary),
    );
  }
}
