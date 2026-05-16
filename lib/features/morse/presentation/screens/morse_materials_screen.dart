import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/app_header_bar.dart';
import '../../../../core/widgets/filter_chip_row.dart';
import '../providers/morse_translation_repository_provider.dart';
import '../widgets/morse_list_item.dart';

class MorseMaterialsScreen extends ConsumerStatefulWidget {
  const MorseMaterialsScreen({super.key});

  @override
  ConsumerState<MorseMaterialsScreen> createState() =>
      _MorseMaterialsScreenState();
}

class _MorseMaterialsScreenState extends ConsumerState<MorseMaterialsScreen> {
  int _filterIndex = 0;

  static const _filters = ['Vsi', 'Črke', 'Številke'];

  @override
  Widget build(BuildContext context) {
    final allEntries = ref.watch(morseDictionaryProvider);

    final filtered = switch (_filterIndex) {
      1 => allEntries
          .where((e) => RegExp(r'^[A-ZŠĆŽ]$').hasMatch(e.character))
          .toList(),
      2 => allEntries
          .where((e) => RegExp(r'^[0-9]$').hasMatch(e.character))
          .toList(),
      _ => allEntries,
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeaderBar(
        title: 'Morsejeva abeceda',
        showBackButton: true,
        onSettingsPressed: () => context.goNamed(RouteNames.settings),
      ),
      body: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          FilterChipRow(
            options: _filters,
            selectedIndex: _filterIndex,
            onSelected: (i) => setState(() => _filterIndex = i),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.base, vertical: AppSpacing.sm),
              itemCount: filtered.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (_, index) => MorseListItem(entry: filtered[index]),
            ),
          ),
        ],
      ),
    );
  }
}
