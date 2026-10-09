import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Базовый контейнер: скругление 24, опциональное неоновое свечение (BoxShadow).
class BaseContainer extends StatelessWidget {
  const BaseContainer({
    super.key,
    required this.child,
    this.neonColor,
    this.padding = EdgeInsets.zero,
    this.color = AppColors.surface,
    this.radius = AppSizes.radius,
  });

  final Widget child;
  final Color? neonColor;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          border: neonColor == null ? null : Border.all(color: neonColor!, width: 1.5),
          boxShadow: neonColor == null
              ? null
              : [
                  BoxShadow(color: neonColor!.withOpacity(0.55), blurRadius: 14, spreadRadius: 1),
                  BoxShadow(color: neonColor!.withOpacity(0.25), blurRadius: 30, spreadRadius: 3),
                ],
        ),
        child: child,
      );
}
