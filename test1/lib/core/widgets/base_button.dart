import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'base_container.dart';
import 'base_text.dart';

/// Базовая кнопка с неоновой рамкой.
class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.color = AppColors.neonGreen,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: BaseContainer(
          neonColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (icon != null) ...[Icon(icon, color: color, size: 18), const SizedBox(width: 8)],
            BaseText(label, color: color, size: 13),
          ]),
        ),
      );
}
