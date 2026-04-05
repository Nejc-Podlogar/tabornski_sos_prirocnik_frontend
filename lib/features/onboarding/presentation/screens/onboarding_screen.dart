import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/route_names.dart';
import '../providers/onboarding_notifier.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _currentIndex = 0;

  static const _slides = [
    _SlideData(
      overline: 'TABORNIŠKI S.O.S PRIROČNIK',
      title: 'DOBRODOŠEL\nMED SKAVTE',
      body: 'Vse kar potrebuješ za taborniško izkušnjo — na enem mestu.',
    ),
    _SlideData(
      overline: 'MORSE, SEMAFOR, ORIENTACIJA',
      title: 'NAUČI SE\nZNAKOV',
      body: 'Vaje, prevajanje in referenčno gradivo za vse taborniške veščine.',
    ),
    _SlideData(
      overline: 'BREZ INTERNETA',
      title: 'VEDNO\nPRIPRAVLJEN',
      body: 'Aplikacija deluje brez internetne povezave — tudi v naravi.',
    ),
  ];

  bool get _isLast => _currentIndex == _slides.length - 1;

  Future<void> _advance() async {
    if (_isLast) {
      await _completeOnboarding();
    } else {
      setState(() => _currentIndex++);
    }
  }

  Future<void> _completeOnboarding() async {
    await ref.read(onboardingNotifierProvider.notifier).markSeen();
    if (mounted) context.goNamed(RouteNames.home);
  }

  void _skip() {
    // Skip still marks onboarding as seen to avoid repeat
    _completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final slide = _slides[_currentIndex];
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.xxxl),

                  // Overline
                  Text(slide.overline.toUpperCase(),
                      style: AppTypography.overline.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.6))),
                  const SizedBox(height: AppSpacing.base),

                  // Title
                  Text(slide.title,
                      style: AppTypography.screenTitle.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                        height: 1.1,
                      )),
                  const SizedBox(height: AppSpacing.xl),

                  // Body
                  Text(slide.body,
                      style: AppTypography.body.copyWith(
                          color: AppColors.textPrimary.withOpacity(0.85),
                          fontSize: 16)),

                  const Spacer(),

                  // Progress pills
                  Row(
                    children: List.generate(_slides.length, (i) {
                      final isActive = i == _currentIndex;
                      return Container(
                        margin: const EdgeInsets.only(
                            right: AppSpacing.xs),
                        width: isActive ? 24 : 8,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.textPrimary
                              : AppColors.textPrimary.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Next button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _advance,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.textPrimary,
                        foregroundColor: AppColors.primary,
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        _isLast ? 'ZAČNI' : 'NASLEDNJI KORAK',
                        style: AppTypography.buttonLabel
                            .copyWith(color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.base),

                  // Skip link
                  if (!_isLast)
                    Center(
                      child: TextButton(
                        onPressed: _skip,
                        child: Text('PRESKOČI UVOD',
                            style: AppTypography.caption.copyWith(
                                color:
                                    AppColors.textPrimary.withOpacity(0.5))),
                      ),
                    ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),

            // Mountain silhouette strip at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: size.height * 0.18,
                child: CustomPaint(
                  painter: _MountainPainter(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlideData {
  const _SlideData({
    required this.overline,
    required this.title,
    required this.body,
  });

  final String overline;
  final String title;
  final String body;
}

/// Paints a simple mountain/tree silhouette strip.
class _MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.mountainSilhouette.withOpacity(0.25)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.5)
      ..lineTo(size.width * 0.1, size.height * 0.2)
      ..lineTo(size.width * 0.2, size.height * 0.55)
      ..lineTo(size.width * 0.32, size.height * 0.1)
      ..lineTo(size.width * 0.44, size.height * 0.45)
      ..lineTo(size.width * 0.55, size.height * 0.25)
      ..lineTo(size.width * 0.67, size.height * 0.5)
      ..lineTo(size.width * 0.78, size.height * 0.15)
      ..lineTo(size.width * 0.9, size.height * 0.4)
      ..lineTo(size.width, size.height * 0.3)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_MountainPainter oldDelegate) => false;
}
